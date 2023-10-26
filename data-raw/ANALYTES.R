library(MotrpacRatTrainingPhysiologyData)
library(dplyr)

PHYSIO <- get0("PHYSIO",
               envir = asNamespace("MotrpacRatTrainingPhysiologyData"))

ANALYTES <- PHYSIO %>%
  dplyr::select(pid, iowa_id, omics_analysis, age, sex, group,
                runseq, ketones:insulin_pm) #%>%
# mutate(notes = ifelse(iowa_id == "18FST30", "low volume", NA)) # 1W control

# Reorder analyte columns
analyte_cols <- ANALYTES %>%
  select(ketones:insulin_pm) %>%
  select(order(colnames(.)))

ANALYTES <- ANALYTES %>%
  select(pid:runseq) %>%
  cbind(analyte_cols)

usethis::use_data(ANALYTES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)
