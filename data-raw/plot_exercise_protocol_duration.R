library(MotrpacRatTraining6moData)
library(dplyr)
library(lubridate)
library(ggplot2)
library(tidyr)

x <- PHENO %>%
  # filter(pid %in% MotrpacRatTraining6moWATData::PROT_EXP$pid) %>%
  select(pid, sex, group, key.d_sacrifice) %>%
  distinct() %>%
  mutate(key.d_sacrifice = dmy(key.d_sacrifice)) %>%
  arrange(key.d_sacrifice)

x %>%
  group_by(sex, group) %>%
  summarise(date_range = max(key.d_sacrifice) - min(key.d_sacrifice))


y <- PHENO %>%
  select(pid, sex, group, registration.d_birth, registration.d_arrive,
         matches("training.day\\d+date")) %>%
  # filter(pid %in% MotrpacRatTraining6moWATData::PROT_EXP$pid) %>%
  distinct() %>%
  pivot_longer(cols = starts_with("training"),
               names_to = "day",
               names_pattern = "training.day(\\d+)date",
               values_to = "training_date") %>%
  mutate(registration.d_birth = my(registration.d_birth),
         registration.d_arrive = dmy(registration.d_arrive),
         training_date = dmy(training_date),
         # training_date = training_date - registration.d_birth,
         # training_date = as.numeric(training_date),
         day = as.numeric(day),
         sex = factor(sub("(.)", "\\U\\1", sex, perl = TRUE),
                      levels = c("Female", "Male")),
         group = ifelse(group == "control", "SED", toupper(group)),
         group = factor(group, levels = c("SED", paste0(2 ^ (0:3), "W")))) %>%
  filter(!is.na(training_date)) %>%
  group_by(pid) %>%
  filter(day == 1 | day == max(day)) %>%
  ungroup() %>%
  mutate(day = ifelse(day == 1, "start", "end")) %>%
  distinct() %>%
  pivot_wider(id_cols = c(pid:registration.d_arrive),
              names_from = day,
              values_from = training_date) %>%
  arrange(group, sex, start, end) %>%
  group_by(group) %>%
  mutate(pid_rank = 1:n(),
         pid_rank = pid_rank - median(pid_rank)) %>%
  ungroup() %>%
  mutate(pid_rank = as.numeric(group) +
           scales::rescale(pid_rank, to = 0.35 * c(-1, 1)))


ggplot(y, aes(y = group)) +
  geom_segment(aes(x = start, xend = end,
                   y = pid_rank, yend = pid_rank,
                   color = sex), linewidth = 0.6) +
  labs(#x = "Days passed since first day of birth month",
    x = "Start and end of training",
       y = NULL,
       title = "MoTrPAC Exercise Protocol Duration",
       subtitle = paste("Lines range from the start to the end of the",
                        "protocol, including rest days")) +
  # scale_x_continuous(breaks = seq(190, 250, 10),
  #                    limits = c(185, 250),
  #                    expand = expansion(0)) +
  scale_y_continuous(breaks = 1:5, labels = levels(y$group)) +
  scale_color_manual(name = "Sex",
                     values = c("#ff6eff", "#5555ff")) +
  theme_minimal() +
  theme(axis.text.x = element_text(color = "black",
                                   angle = 45, hjust = 1, vjust = 1),
        axis.text.y = element_text(color = "black", size = rel(1.4)),
        axis.line = element_line(color = "black"),
        axis.ticks.x = element_line(color = "black"),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        plot.subtitle = element_text(color = "grey40"))

ggsave("./plots/exercise_protocol_duration.png",
       height = 3.5, width = 6, dpi = 300, bg = "white")

y %>%
  group_by(sex, group) %>%
  transmute(diff = end - start) %>%
  distinct()

mean(y$end[y$group == "SED"]) - mean(y$start[y$group == "1W"])


# Approximate start and end ages
start_1 <- range(y$start) / 30 # convert from days to months
start <- start_1 - c(1, 0) # max starting age range
diff(start) / 2 # 0.78333
mean(start) # 6.016667

end_1 <- range(y$end) / 30
end <- end_1 - c(1, 0) # max ending age range
diff(end) / 2 # 1.25
mean(end) # 6.98333

