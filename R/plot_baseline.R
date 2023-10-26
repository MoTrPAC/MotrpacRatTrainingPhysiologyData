#' @title Plot baseline or pre-training measures
#'
#' @description Plot baseline or pre-training measures.
#'
#' @param x a \code{data.frame} with columns \code{"sex"}, \code{"age"},
#'   \code{"group"}, and a column specified by \code{response}.
#' @param response character; the name of a column in \code{x} to plot.
#' @param conf a \code{data.frame} with confidence interval data.
#' @param stats optional \code{data.frame} with results of statistical analyses
#'   filtered to the response of interest.
#' @param sex character; the sex of the samples to plot: "Female" or "Male".
#' @param age character; the age of the samples to plot: "6M" or "18M".
#' @param y_position numeric; manually specify starting y position of p-value
#'   brackets.
#'
#' @import ggplot2
#' @importFrom dplyr %>% rename filter
#' @importFrom rlang !! sym
#' @importFrom ggsignif geom_signif
#' @importFrom ggbeeswarm position_beeswarm
#'
#' @export plot_baseline

plot_baseline <- function(x,
                          response,
                          conf,
                          stats,
                          sex = c("Female", "Male"),
                          age = c("6M", "18M"),
                          y_position = NULL)
{
  x <- x %>%
    dplyr::rename(response = !!sym(response)) %>%
    filter(!is.na(response), sex == !!sex, age == !!age) %>%
    droplevels.data.frame()

  # Base plot
  p <- ggplot(data = x, aes(x = group, y = response))

  # Add
  if (missing(conf)) {
    p <- p +
      stat_summary(fun.data = ~ exp(mean_cl_normal(log(.x))),
                   geom = "crossbar", fatten = 1, linewidth = 0.4,
                   color = ifelse(sex == "Female", "#ff63ff", "#5555ff"))

  } else {
    conf <- conf %>%
      filter(sex == !!sex, age == !!age, group %in% x$group)

    # if (any(grepl("^asymp", colnames(conf)))) {
    #   conf <- conf %>%
    #     mutate(lower.CL = ifelse(is.na(lower.CL), asymp.LCL, lower.CL),
    #            upper.CL = ifelse(is.na(upper.CL), asymp.UCL, upper.CL))
    # }
    p <- p +
      geom_crossbar(aes(x = group, y = response_mean,
                        ymin = lower.CL, ymax = upper.CL),
                    data = conf, fatten = 1, linewidth = 0.4,
                    color = ifelse(sex == "Female", "#ff6eff", "#5555ff"))
  }

  # workaround to avoid warning messages
  cart <- coord_cartesian(clip = "off", xlim = c(1, 2.5))
  cart$default <- TRUE

  p <- p +
    geom_point(color = "black", na.rm = TRUE, shape = 16,
               position = position_beeswarm(cex = 3, dodge.width = 0.7),
               size = 0.4) +
    labs(x = NULL) +
    cart +
    theme_bw(base_size = 7) +
    theme(text = element_text(size = 7, color = "black"),
          line = element_line(linewidth = 0.3, color = "black"),
          axis.ticks = element_line(linewidth = 0.3, color = "black"),
          panel.grid = element_blank(),
          panel.border = element_blank(),
          axis.ticks.x = element_blank(),
          axis.text = element_text(size = 7,
                                   color = "black"),
          axis.text.x = element_text(size = 7, angle = 90, hjust = 1,
                                     vjust = 0.5),
          axis.title = element_text(size = 7, margin = margin(),
                                    color = "black"),
          axis.line = element_line(linewidth = 0.3),
          strip.background = element_blank(),
          strip.text = element_blank(),
          panel.spacing = unit(-1, "pt"),
          plot.title = element_text(size = 7, color = "black"),
          plot.subtitle = element_text(size = 7, color = "black"),
          legend.position = "none",
          strip.placement = "outside"
    )

  if (!missing(stats)) {
    # Add asterisks and brackets for significant comparisons
    stats <- stats %>%
      filter(sex == !!sex, age == !!age, signif)

    if (!"comparisons" %in% colnames(stats)) {
      stats <- stats %>%
        mutate(comparisons = strsplit(as.character(contrast), split = " / "))
    }

    if (nrow(stats) > 0) {
      p <- p +
        geom_signif(
          textsize = 6 / .pt,
          vjust = 0.25,
          color = "black",
          size = 0.3,
          step_increase = 0.08,
          y_position = y_position,
          annotations = rep("", nrow(stats)),
          comparisons = stats$comparisons
        )
    }
  }

  return(p)
}

