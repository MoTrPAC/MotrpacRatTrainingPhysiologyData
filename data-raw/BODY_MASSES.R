library(MotrpacRatTrainingPhysiologyData)
library(dplyr)

PHYSIO <- get0("PHYSIO",
               envir = asNamespace("MotrpacRatTrainingPhysiologyData"))

BODY_MASSES <- PHYSIO %>%
  dplyr::select(pid, iowa_id, age, sex, group, contains("body_mass")) %>%
  dplyr::select(1:12) %>%
  filter(!if_all(contains("body_mass"), is.na)) %>%
  relocate(nmr_post_body_mass, .after = nmr_pre_body_mass)

usethis::use_data(BODY_MASSES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)
