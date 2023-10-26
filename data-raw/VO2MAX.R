library(MotrpacRatTrainingPhysiologyData)
library(dplyr)

PHYSIO <- get0("PHYSIO",
               envir = asNamespace("MotrpacRatTrainingPhysiologyData"))

VO2MAX <- PHYSIO %>%
  dplyr::select(pid, iowa_id, age, sex, group, starts_with("vo2")) %>%
  filter(!if_all(starts_with("vo2"), is.na)) %>%
  rename_with(.fn = ~ sub("vo2_", "", .x),
              .cols = starts_with("vo2"))

usethis::use_data(VO2MAX, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)

