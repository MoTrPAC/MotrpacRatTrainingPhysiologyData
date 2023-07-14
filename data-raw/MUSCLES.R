library(MotrpacRatTrainingPhysiologyData)
library(dplyr)

MUSCLES <- PHYSIO %>%
  select(pid, iowa_id, sex, group, age, starts_with("term_"),
         starts_with("meancsa_"), starts_with("glyc_"),
         starts_with("meancc_"), starts_with("cs_")) %>%
  select(-term_weight) %>%
  rename_with(~ sub("_weight$", "", .x)) %>%
  pivot_longer(cols = -c(pid, sex, group, age),
               names_to = c(".value", "muscle"),
               names_pattern = "(.*)_(.*)") %>%
  rename(term_weight = term,
         mean_CSA = meancsa,
         glycogen = glyc,
         capillary_contacts = meancc,
         citrate_synthase = cs) %>%
  filter(!if_all(c(term_weight, mean_CSA,
                   glycogen, capillary_contacts,
                   citrate_synthase), is.na)) %>%
  mutate(muscle = toupper(muscle))

usethis::use_data(MUSCLES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)
