library(MotrpacRatTrainingPhysiologyData)
library(dplyr)
library(tidyr)
library(readxl)

fiber_count_df <- file.path("data-raw", "fiber_type_counts.xlsx") %>%
  read_xlsx(sheet = "combined") %>%
  pivot_longer(cols = contains("Type"),
               names_to = "type",
               values_to = "fiber_count") %>%
  na.omit() %>%
  mutate(type = sub("Type ", "", type),
         type = gsub("([ABX])", "\\L\\1", type, perl = TRUE)) %>%
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
  full_join(fiber_count_df, by = colnames(fiber_count_df)[1:6]) %>%
  filter(!is.na(fiber_area) | !is.na(fiber_count),
         group %in% c("SED", "8W")) %>%
  mutate(type = factor(type, levels = sort(unique(type))),
         group = factor(group, levels = c("SED", "8W")))

# 06F8T24 SOL IIa has 0 fiber count, but has a fiber area!!!

usethis::use_data(FIBER_TYPES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)

