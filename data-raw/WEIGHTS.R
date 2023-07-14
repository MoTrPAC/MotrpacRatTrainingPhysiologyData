library(MotrpacRatTrainingPhysiologyData)
library(dplyr)

WEIGHTS <- PHYSIO %>%
  dplyr::select(pid, iowa_id, age, sex, group, contains("weight")) %>%
  dplyr::select(1:12) %>%
  filter(!if_all(contains("weight"), is.na))

usethis::use_data(WEIGHTS, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)
