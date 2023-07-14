library(MotrpacRatTrainingPhysiologyData)
library(dplyr)

NMR <- PHYSIO %>%
  dplyr::select(pid, iowa_id, age, sex, group, starts_with("nmr_")) %>%
  filter(!if_all(starts_with("nmr"), is.na)) %>%
  rename_with(.fn = ~ sub("nmr_", "", .x),
              .cols = starts_with("nmr"))

usethis::use_data(NMR, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)
