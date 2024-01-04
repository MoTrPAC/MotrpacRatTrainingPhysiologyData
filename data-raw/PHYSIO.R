library(readxl)
library(dplyr)
library(purrr)
library(tibble)
library(tidyr)
library(lubridate)

# Unsupervised renaming of columns
rename_fn <- function(x) {
  x %>%
    rename_with(tolower) %>%
    rename_with(~ gsub("_?%", "_pct", .x)) %>%
    rename_with(~ gsub("[(]|[)]|\\/|\\.", "_", .x)) %>%
    rename_with(~ gsub("__", "_", .x)) %>%
    rename_with(~ sub("_$", "", .x))
}

## Master spreadsheet with most measures
sheets <- c("Female 6M", "Male 6M", "Female 18M", "Male 18M")

PHYSIO <- map(sheets, function(sheet_i) {
  file.path("data-raw", "master_spreadsheet.xlsx") %>%
    read_xlsx(sheet = sheet_i)
}) %>%
  setNames(sheets) %>%
  enframe() %>%
  separate(col = name, into = c("sex", "age"), remove = TRUE) %>%
  unnest(cols = value) %>%
  rename_fn() %>%
  distinct() %>%
  # Fix 18M Iowa IDs (necessary to join clinical analyte data)
  mutate(iowa_id = ifelse(grepl("^18F8", iowa_id) & grepl("4", group),
                          sub("18F8", "18F4", iowa_id), iowa_id))

## Add clinical analyte data
bid_to_iowa <- file.path("data-raw", "18M_id_conversion.csv") %>%
  read.csv()

analyte_df <- file.path("data-raw",
                        c("20220830_PASS1B-06_clinical_analytes_updated.csv",
                          "20230208_PASS1B-18_clinical_analytes_updated.csv")) %>%
  map(function(file_i) {
    read.csv(file_i) %>%
      rename_fn() %>%
      dplyr::rename(insulin_iu = insulin_uu_ml) %>%
      dplyr::select(-insulin_glucagon_molar_ratio) # See Kronmal 1995
  }) %>%
  setNames(c("6M", "18M"))

analyte_df[["18M"]] <- left_join(analyte_df[["18M"]], bid_to_iowa, by = "bid")

PHYSIO <- split.data.frame(PHYSIO, f = PHYSIO$age)

PHYSIO[["6M"]] <- left_join(PHYSIO[["6M"]], analyte_df[["6M"]],
                            by = "pid")
PHYSIO[["18M"]] <- left_join(PHYSIO[["18M"]], analyte_df[["18M"]],
                             by = "iowa_id")

PHYSIO <- plyr::rbind.fill(PHYSIO) %>%
  dplyr::select(-c(viallabel, bid)) %>%
  filter(group != "Control: 1 Week") %>% # remove 1W controls for now
  mutate(pid = as.character(pid),
         group = sub(" Weeks?", "W", group),
         group = ifelse(grepl("Control", group), "SED", group),
         group = factor(group, levels = c("SED", paste0(2 ^ (0:3), "W"))),
         sex = factor(sex, levels = c("Female", "Male")),
         age = factor(age, levels = c("6M", "18M")),
         omics_analysis = !is.na(omics_analysis),
         across(.cols = where(is.character),
                ~ ifelse(.x == "0", NA_character_, .x)),
         # Correct dates in Date objects
         across(.cols = contains("vo2_pre_t"), function(pre_t) {
           date(pre_t) <- vo2_pre_d
           return(pre_t)
         }),
         across(.cols = contains("vo2_post_t"), function(post_t) {
           date(post_t) <- vo2_post_d
           return(post_t)
         }),
         # Remove glycogen values if they are negative (assay artifact caused
         # over-correcting when there is a lot of glucose)
         across(.cols = starts_with("glyc_"), ~ ifelse(.x < 0, NA, .x)),
         # Pre values
         nmr_pre_fat = nmr_pre_fat_pct / 100 * nmr_pre_weight,
         nmr_pre_lean = nmr_pre_lean_pct / 100 * nmr_pre_weight,

         # Post values
         nmr_post_fat = nmr_post_fat_pct / 100 * nmr_post_weight,
         nmr_post_lean = nmr_post_lean_pct / 100 * nmr_post_weight) %>%
  select(-ends_with("_d")) %>%
  relocate(nmr_pre_fat, nmr_pre_lean, .after = nmr_pre_weight) %>%
  relocate(nmr_post_fat, nmr_post_lean, .after = nmr_post_weight) %>%
  arrange(age, sex, group, pid) %>%
  rename_with(.cols = contains("weight"),
              .fn = ~ sub("weight", "body_mass", .x)) %>%
  rename_with(.cols = c(starts_with("term"), -term_body_mass),
              .fn = ~ sub("body", "muscle", .x))

usethis::use_data(PHYSIO, internal = TRUE, overwrite = TRUE,
                  compress = "bzip2", version = 3)

