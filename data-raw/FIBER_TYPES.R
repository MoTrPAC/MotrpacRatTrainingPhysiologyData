library(MotrpacRatTrainingPhysiologyData)
library(dplyr)
library(tidyr)
library(readxl)

PHYSIO <- get0("PHYSIO",
               envir = asNamespace("MotrpacRatTrainingPhysiologyData"))

fiber_count_df <- file.path("data-raw", "fiber_type_counts.xlsx") %>%
  read_xlsx(sheet = "combined") %>%
  mutate(age = factor(age, levels = c("6M", "18M")),
         sex = factor(sex, levels = c("Female", "Male")),
         group = factor(group, levels = c("SED", "8W")),
         muscle = factor(muscle, levels = c("LG", "MG", "PL", "SOL"))) %>%
  pivot_longer(cols = contains("Type"),
               names_to = "type",
               values_to = "fiber_count") %>%
  na.omit() %>%
  mutate(type = sub("Type ", "", type),
         type = gsub("([ABX])", "\\L\\1", type, perl = TRUE)) %>%

  # Fix data-entry errors
  pivot_wider(id_cols = c(age, ID, muscle, sex, group),
              names_from = type,
              values_from = fiber_count) %>%
  mutate(tmp = IIa,
         swap = !is.na(IIa) & !is.na(IIb) & IIb < IIa &
           muscle %in% c("LG", "MG") & sex == "Female",
         IIa = ifelse(swap, IIb, IIa),
         IIb = ifelse(swap, tmp, IIb)) %>%
  dplyr::select(-c(tmp, swap)) %>%

  pivot_longer(cols = c(I, IIa, IIb, IIx),
               names_to = "type",
               values_to = "fiber_count") %>%
  filter(!is.na(fiber_count)) %>%
  group_by(age, sex, ID, muscle) %>%
  mutate(total_fiber_count = sum(fiber_count)) %>%
  ungroup()

FIBER_TYPES <- PHYSIO %>%
  dplyr::select(pid, iowa_id, sex, group, age, contains("type")) %>%
  pivot_longer(cols = contains("type"),
               names_to = "muscle",
               values_to = "fiber_area") %>%
  mutate(type = sub(".*_", "", muscle),
         type = gsub("i", "I", type),
         muscle = toupper(sub("_.*", "", muscle))) %>%
  relocate(type, .after = muscle) %>%
  # Add counts for each fiber type
  mutate(ID = as.numeric(sub(".*T", "", iowa_id))) %>%
  full_join(fiber_count_df,
            by = c("ID", "age", "sex", "group", "muscle", "type")) %>%
  filter(!is.na(fiber_area) | !is.na(fiber_count),
         group %in% c("SED", "8W")) %>%
  mutate(age = factor(age, levels = c("6M", "18M")),
         sex = factor(sex, levels = c("Female", "Male")),
         group = factor(group, levels = c("SED", "8W")),
         muscle = factor(muscle, levels = c("LG", "MG", "PL", "SOL")),
         type = factor(type, levels = c("I", "IIa", "IIx", "IIb")),
         across(.cols = c(pid, iowa_id),
                .f = ~ factor(.x, levels = sort(unique(.x)))),
         across(.cols = contains("fiber_count"), as.integer)) %>%
  arrange(age, sex, group, iowa_id, muscle, type) %>%
  select(-ID)

## Fix data-entry errors
FIBER_TYPES <- FIBER_TYPES %>%
  mutate(id_num = sub(".*T(\\d+)$", "\\1", iowa_id),
         id_num = as.numeric(id_num)) %>%
  arrange(age, sex, group, id_num, muscle, type)

idx <- with(FIBER_TYPES, age == "18M" & sex == "Female" &
              muscle == "SOL" & type == "IIa")

FIBER_TYPES[idx, ] <- FIBER_TYPES[idx, ] %>%
  mutate(fiber_area = lag(fiber_area, n = 1, default = NA))

## Double-check
View(FIBER_TYPES[idx, ])
#3 = NA
#5 = 804.8
#6 = 946.7
#7 = 1196.0
#16 = 1119.0
#22 = 1158.0
#13 = 1231.0
#14 = 1020.0
#15 = 1104.0
#17 = 1355.0
#26 = 1132.0
#28 = 1144.0

# Remove id_num column
FIBER_TYPES <- select(FIBER_TYPES, -id_num) %>%
  mutate(across(.cols = c(pid, iowa_id), as.character))

usethis::use_data(FIBER_TYPES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)

