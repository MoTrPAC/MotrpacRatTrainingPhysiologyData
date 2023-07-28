library(MotrpacRatTrainingPhysiologyData)
library(dplyr)
library(purrr)
library(tibble)
library(tidyr)
library(writexl)

## Table S4: trained vs. SED comparisons =======================================
s4 <- list(
  "NMR & VO2MAX measures" = BASELINE_STATS,
  "Plasma analytes" = ANALYTES_STATS,
  "Muscle measures" = MUSCLES_STATS %>%
    mutate(response = ifelse(response == "Glycogen",
                             "Muscle Glycogen", response),
           response = sub("Terminal Weight",
                          "Terminal Muscle Mass", response))
) %>%
  map(function(xi) {
    xi %>%
      mutate(pct_change = 100 * (ratio - 1),
             age = ifelse(is.na(age), "6M, 18M", as.character(age))) %>%
      separate_rows(age, sep = ", ") %>%
      relocate(pct_change, .after = ratio) %>%
      relocate(contrast, model_type, any_of(c("estimate")), .after = sex) %>%
      dplyr::select(response:pct_change, p.value, signif) %>%
      mutate(model_type = ifelse(model_type == "Wilcoxon",
                                 "wilcox.test", model_type),
             age = factor(age, levels = c("6M", "18M")),
             sex = factor(sex, levels = c("Female", "Male")),
             response = sub("Weight", "Mass", response),
             response = ifelse(response == "NMR Mass",
                               "NMR Body Mass", response),
             response = factor(response, levels = unique(response)),
             across(any_of(c("estimate", "pct_change")), round),
             ratio = round(ratio, digits = 2),
             p.value = signif(p.value, digits = 3)) %>%
      arrange(response, age, sex, contrast) %>%
      dplyr::rename(any_of(c("mean_rank_diff" = "estimate")),
                    contrast_ratio = ratio)
  })

write_xlsx(s4, path = "./supplementary-tables/supplementary-table-4.xlsx",
           col_names = TRUE, format_headers = TRUE)


## Table S5: post - pre training differences ===================================
x <- BASELINE_EMM %>%
  map(function(.x) {
    out <- summary(.x) %>%
      dplyr::rename(any_of(c("pre_emmean" = "response",
                             "pre_emmean" = "rate")))
    if ("age_group" %in% colnames(out)) {
      out <- mutate(out,
                    age = sub("_.*", "", age_group),
                    group = sub(".*_", "", age_group))
    }

    return(out)
  }) %>%
  enframe(name = "response") %>%
  unnest(value) %>%
  dplyr::select(response, group, age, sex, pre_emmean)

x2 <- filter(x, response == "NMR Weight") %>%
  mutate(response = "Term - NMR Pre Weight")

x <- rbind(x, x2)

s5 <- PRE_POST_STATS %>%
  mutate(sex = ifelse(is.na(sex), "Female, Male", as.character(sex))) %>%
  separate_rows(sex, sep = ", ") %>%
  left_join(x, by = c("response", "group", "age", "sex")) %>%
  mutate(pct_change = 100 * emmean / pre_emmean,
         across(c(where(is.numeric), -p.value), ~ round(.x, digits = 0)),
         p.value = signif(p.value, digits = 3),
         age = factor(age, levels = c("6M", "18M")),
         sex = factor(sex, levels = c("Female", "Male")),
         group = factor(group, levels = c("SED", paste0(2 ^ (0:3), "W"))),
         model_type = ifelse(model_type == "Wilcoxon",
                             "wilcox.test", model_type),
         response = sub("Term ", "Terminal ", response),
         response = sub("Weight", "Mass", response),
         response = ifelse(response == "NMR Mass", "NMR Body Mass", response),
         response = factor(response, levels = unique(response))) %>%
  relocate(pre_emmean, pct_change, p.value, signif, .after = emmean) %>%
  relocate(model_type, estimate, .after = group) %>%
  dplyr::rename(`mean_post-pre_diff` = emmean, pre_mean = pre_emmean,
                mean_rank_diff = estimate) %>%
  dplyr::select(response:signif) %>%
  arrange(response, age, sex, group)

write_xlsx(s5, path = "./supplementary-tables/supplementary-table-5.xlsx",
           col_names = TRUE, format_headers = TRUE)

