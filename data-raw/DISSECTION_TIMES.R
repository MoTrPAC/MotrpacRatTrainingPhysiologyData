library(MotrpacRatTrainingPhysiologyData)
library(dplyr)
library(lubridate)
library(ggplot2)
library(scales)

## 6-month data ================================================================
sp6 <- read.csv("./data-raw/DMAQC_Transfer_PASS_1B.6M_1.02_DS_MoTrPAC.PASS_Animal.Specimen.Processing.csv") %>%
  mutate(aliquotdescription = ifelse(grepl("Aorta", aliquotdescription),
                                     "Vena Cava", aliquotdescription)) #%>%
  # select(pid, contains("description"), starts_with("t_"))

sc6 <- read.csv("./data-raw/DMAQC_Transfer_PASS_1B.6M_1.02_DS_MoTrPAC.PASS_Animal.Specimen.Collection.csv") #%>%
  # select(pid, starts_with("t_"), -contains("uterus"))

x6 <- full_join(sp6, sc6, by = "pid")

unique(x6$aliquotdescription)

## 18-month data ===============================================================
sp18 <- read.csv("./data-raw/DMAQC_Transfer_PASS_1B.18M_1.00_DS_MoTrPAC.PASS_Animal.Specimen.Processing.csv") #%>%
  # select(pid, contains("description"), starts_with("t_"))

sc18 <- read.csv("./data-raw/DMAQC_Transfer_PASS_1B.18M_1.00_DS_MoTrPAC.PASS_Animal.Specimen.Collection.csv") #%>%
  # select(pid, starts_with("t_"), -contains("uterus"))

x18 <- full_join(sp18, sc18, by = "pid")

dissection_order <- c(
  # Heart puncture
  "Soleus" = "Soleus",
  "Plantaris" = "Plantaris",
  "Gastrocnemius (Right)" = "Gastrocnemius",
  "Gastrocnemius" = "Gastrocnemius",
  "White Adipose" = "White Adipose",
  "Liver" = "Liver",
  "Vena Cava" = "Vena Cava",
  "Lung" = "Lung",
  # Decapitation
  # Brain dissection
  "Cortex Right" = "Cortex (right)",
  "Cortex Left" = "Cortex (left)",
  "Hypothalamus" = "Hypothalamus",
  "Hippocampus" = "Hippocampus",
  # Dissection of remaining tissues
  "Heart" = "Heart",
  "Aorta" = "Aorta",
  "Kidney" = "Kidney",
  "Adrenals (both)" = "Adrenals (both)",
  "Spleen" = "Spleen",
  "Brown Adipose" = "Brown Adipose",
  "Small Intestine" = "Jejunum",
  "Colon" = "Colon",
  "Feces" = "Feces",
  "Testes (left)" = "Testes (left)",
  "Ovaries (both)" = "Ovaries (both)",
  "Vastus Lateralis" = "Vastus Lateralis",
  "Tibia" = "Tibia",
  "Femur" = "Femur"
)

DISSECTION_TIMES <- plyr::rbind.fill(x6, x18) %>%
  # select(pid:aliquotdescription, t_collection, t_freeze, t_death) %>%
  select(pid, techid, sampletypedescription,
         aliquotdescription, t_collection, t_freeze, t_death) %>%
  filter(t_collection != "",
         !grepl("Histology", aliquotdescription),
         sampletypedescription != "PaxGene RNA") %>%
  mutate(pid = as.character(pid),
         aliquotdescription = sub(".*mL ", "", aliquotdescription),
         aliquotdescription = dissection_order[aliquotdescription],
         aliquotdescription = factor(aliquotdescription,
                                     levels = unique(dissection_order)),
         across(c(t_collection, t_death, t_freeze), ~ seconds(hms(.x))),
         # Fix data-entry errors
         t_freeze = case_when(
           pid == "12626880" & aliquotdescription %in%
             c("Hippocampus", "Hypothalamus", "Kidney") ~ t_freeze + 3600,
           (pid == "11621443" & aliquotdescription == "Cortex (left)") |
             (pid == "11464089" & aliquotdescription == "Liver") ~ t_freeze + 60,
           TRUE ~ t_freeze),
         t_death = ifelse(pid == "10059369" & aliquotdescription == "Heart",
                          t_collection, t_death),

         across(c(t_collection, t_death, t_freeze),
                ~ as.integer(.x - pmin(t_collection, t_death, t_freeze))),
         collect_before_death = aliquotdescription %in% dissection_order[1:8],
         freeze_after_death = ifelse(!collect_before_death,
                                     t_freeze >= t_death, NA),
         freeze_after_collect = t_freeze >= t_collection) %>%
  # Data only available for 18M animals
  filter(!aliquotdescription %in% c("Femur", "Soleus", "Plantaris"))

# Fix data entry errors (swap t_freeze and t_collection for a few rows)
idx <- which(with(DISSECTION_TIMES, !freeze_after_death | !freeze_after_collect))
DISSECTION_TIMES[idx, c("t_freeze", "t_collection")] <-
  DISSECTION_TIMES[idx, c("t_collection", "t_freeze")]

DISSECTION_TIMES$freeze_after_collect[idx] <- TRUE

DISSECTION_TIMES <- DISSECTION_TIMES %>%
  mutate(t_diff = ifelse(collect_before_death,
                         t_freeze - t_collection,
                         t_freeze - t_death)) %>%
  left_join(select(PHYSIO, pid, age, sex, group), by = "pid") %>%
  # Several pid not in master spreadsheet (1W controls for 18M)
  filter(!is.na(sex), !is.na(age)) %>%
  relocate(t_freeze, .after = t_death)

152 * 19 + 23 * 130 # 5878 rows
# DISSECTION_TIMES has 6035 rows before removing those with missing sex or age
# and 5759 rows after.

## Used to identify data entry errors
# DISSECTION_TIMES %>%
#   filter(!freeze_after_death | !freeze_after_collect | t_diff < 0) %>%
#   View()

# 11464089 liver t_freeze 49 min, not 48
# 11621443 cortex t_freeze 37 min, not 36
# 12626880 hippocampus and hypothalamus and kidney 12 hr --> 13 hr


# Color-code letters or boxes? panels for dissector
# Separate death from under anesthesia

# Save
usethis::use_data(DISSECTION_TIMES, internal = FALSE, overwrite = TRUE,
                  compress = "bzip2", version = 3)

