library(MotrpacRatTrainingPhysiologyData)
library(dplyr)

PHYSIO <- get0("PHYSIO",
               envir = asNamespace("MotrpacRatTrainingPhysiologyData"))

MUSCLES <- PHYSIO %>%
  select(pid, iowa_id, sex, group, age, starts_with("term_"),
         starts_with("meancsa_"), starts_with("glyc_"),
         starts_with("meancc_"), starts_with("cs_")) %>%
  select(-term_body_mass) %>%
  rename_with(~ sub("_muscle_mass$", "", .x)) %>%
  pivot_longer(cols = -c(pid, iowa_id, sex, group, age),
               names_to = c(".value", "muscle"),
               names_pattern = "(.*)_(.*)") %>%
  rename(term_muscle_mass = term,
         mean_CSA = meancsa,
         glycogen = glyc,
         capillary_contacts = meancc,
         citrate_synthase = cs) %>%
  filter(!if_all(c(term_muscle_mass, mean_CSA,
                   glycogen, capillary_contacts,
                   citrate_synthase), is.na)) %>%
  mutate(muscle = toupper(muscle),
         muscle = factor(muscle, levels = c("LG", "MG", "PL", "SOL"))) %>%
  as.data.frame()

usethis::use_data(MUSCLES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)
