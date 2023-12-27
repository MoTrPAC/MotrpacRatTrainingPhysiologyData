library(MotrpacRatTrainingPhysiologyData)
library(dplyr)
library(purrr)
library(tibble)
library(tidyr)
library(writexl)
library(emmeans)

## Supplementary Table 2: post - pre training differences ======================
# Get pre-training means to calculate % change
x <- BASELINE_EMM %>%
  map(function(.x) {
    out <- summary(.x) %>%
      dplyr::rename(any_of(c("pre_mean" = "response",
                             "pre_mean" = "rate")))
    if ("age_group" %in% colnames(out)) {
      out <- mutate(out,
                    age = sub("_.*", "", age_group),
                    group = sub(".*_", "", age_group))
    }

    return(out)
  }) %>%
  enframe(name = "response") %>%
  unnest(value) %>%
  dplyr::select(response, group, age, sex, pre_mean)

x2 <- filter(x, response == "NMR Body Mass") %>%
  mutate(response = "Term - NMR Pre Body Mass")

x <- rbind(x, x2)

s2 <- PRE_POST_STATS %>%
  left_join(x, by = c("response", "age", "sex", "group")) %>%
  mutate(pct_change = 100 * estimate / pre_mean,
         across(.cols = c(where(is.numeric), -starts_with("p.")),
                .fn = ~ round(.x, digits = 2)),
         pct_change = round(pct_change, digits = 0),
         across(.cols = starts_with("p."),
                .fn = ~ signif(.x, digits = 2)),
         age = factor(age, levels = c("6M", "18M")),
         sex = factor(sex, levels = c("Female", "Male")),
         group = factor(group, levels = c("SED", paste0(2 ^ (0:3), "W"))),
         response = sub("Term ", "Terminal ", response),
         response = factor(response, levels = unique(response))) %>%
  relocate(pre_mean, pct_change, .after = estimate) %>%
  arrange(response, age, sex, group)

# Save
write_xlsx(s2, path = file.path("supplementary-tables",
                                "supplementary_table_2.xlsx"),
           col_names = TRUE, format_headers = TRUE)


## Supplementary Table 3: trained vs. SED comparisons ==========================
s3 <- list(
  "NMR & VO2max" = BASELINE_STATS,
  "Weekly Body Mass" = WEEKLY_BODY_MASS_STATS,
  "Muscle Measures" = mutate(MUSCLES_STATS,
                             response = ifelse(response == "Glycogen",
                                               "Muscle Glycogen", response)),
  "Mean Fiber Area" = FIBER_AREA_STATS,
  "Fiber Count" = FIBER_COUNT_STATS,
  "Plasma Analytes" = ANALYTES_STATS) %>%
  map(function(xi) {
    xi %>%
      mutate(response = factor(response, levels = unique(response)),
             pct_change = ifelse(estimate_type == "ratio",
                                 100 * (estimate - 1), NA),
             pct_change = round(pct_change, digits = 0),
             across(.cols = c(where(is.numeric), -starts_with("p.")),
                    .fn = ~ round(.x, digits = 2)),
             across(.cols = starts_with("p."),
                    .fn = ~ signif(.x, digits = 2))) %>%
      relocate(pct_change, .after = estimate) %>%
      {if ("muscle" %in% colnames(.)) {
        arrange(., response, age, sex, muscle, contrast)
      } else if ("week" %in% colnames(.)) {
        arrange(., response, age, sex, week, contrast)
      } else {
        arrange(., response, age, sex, contrast)
      }} %>%
      # Remove columns with all missing values
      dplyr::select(where(fn = ~ !all(is.na(.x))))
  })

# Save
write_xlsx(s3, path = file.path("supplementary-tables",
                                "supplementary_table_3.xlsx"),
           col_names = TRUE, format_headers = TRUE)


# The supplementary tables are further formatted in Microsoft Excel for ease of
# viewing. Data dictionaries are also added to provide explanations of each
# column.
