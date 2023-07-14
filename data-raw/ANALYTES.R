library(MotrpacRatTrainingPhysiologyData)
library(dplyr)

ANALYTES <- PHYSIO %>%
  dplyr::select(pid, iowa_id, omics_analysis, age, sex, group,
                runseq:insulin_glucagon_molar_ratio) %>%
  mutate(notes = ifelse(iowa_id == "18FST30", "low volume", NA)) # 1W control

usethis::use_data(ANALYTES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)

# x <- y <- ANALYTES %>%
#   filter(age == "6M", !is.na(runseq)) %>%
#   select(-c(insulin_glucagon_molar_ratio, notes, age)) %>%
#   arrange(runseq)
#
# y <- cbind(y[, 1:6], y[, sort(colnames(x[, 7:17]))])
#
#
# write.table(
#   x = y,
#   file = "../MotrpacRatTraining6moWATData/data-raw/6M_clinical_analytes_2023-05-11.txt",
#   quote = FALSE, sep = "\t", row.names = FALSE)

