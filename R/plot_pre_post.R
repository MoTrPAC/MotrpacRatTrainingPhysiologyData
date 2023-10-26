#' @title Plot pre and post-training values
#'
#' @description Create a \code{ggplot2} object with a line for each sample that
#'   spans from its pre-training to post-training value.
#'
#' @param x \code{data.frame} with pre and post values. The data should be
#'   filtered to a specific age and sex.
#' @param pre character; name of a column in \code{x} containing pre-training
#'   values.
#' @param post character; name of a column in \code{x} containing post-training
#'   values.
#' @param stats \code{data.frame} with post - pre stats for each training group.
#'   The data should be filtered to a specific measure, age, and sex.
#'
#' @return A \code{ggplot} object.
#'
#' @details Lines are colored according to whether the change from pre to post
#'   is an increase (red) or decrease (blue). If the pre and post values are the
#'   same (no change), a black point is used instead of a line. Originally, the
#'   post end of each line terminated in an arrow, but the final figure panels
#'   were too small to display them properly. Also, the arrows were somewhat
#'   misleading when the post - pre differences were small enough to be hidden
#'   by the arrow heads.
#'
#' @importFrom dplyr %>% filter rename select mutate arrange group_by ungroup
#'   summarise left_join n case_when
#' @importFrom rlang !! sym
#' @importFrom ggplot2 ggplot geom_segment aes geom_point layer_scales geom_text
#'   scale_color_manual scale_x_continuous guides guide_legend labs
#'   theme_minimal theme element_text element_line element_blank element_rect
#'   margin
#' @importFrom grid unit
#' @importFrom stats na.omit
#'
#' @export

plot_pre_post <- function(x,
                          pre,
                          post,
                          stats = NULL)
{
  # Reformat data
  x <- x %>%
    dplyr::rename(pre = !!sym(pre), post = !!sym(post)) %>%
    mutate(diff = post - pre) %>%
    dplyr::select(pid, age, sex, group, pre, post, diff) %>%
    na.omit() %>%
    droplevels.data.frame() %>%
    arrange(group, pre, post) %>%
    group_by(age, sex, group) %>%
    mutate(rank = 1:n(),
           rank = rank - mean(rank)) %>%
    ungroup() %>%
    mutate(group_num = as.numeric(group),
           group_offset = group_num +
             scales::rescale(rank, to = (0.9 / 2) * c(-1, 1)),
           color = case_when(diff > 0 ~ "Increase",
                             diff < 0 ~ "Decrease",
                             diff == 0 ~ "No Change"))

  # Plot arrows (exclude rows where post - pre = 0)
  p <-
    ggplot(data = filter(x, color != "No Change")) +
    geom_segment(aes(x = group_offset, xend = group_offset,
                     y = pre, yend = post, color = color),
                 lineend = "butt", linejoin = "mitre",
                 linewidth = 0.5)

  # Add squares for samples where post - pre = 0
  p <- p +
    geom_point(data = filter(x, color == "No Change"),
               aes(x = group_offset, y = pre, color = color),
               show.legend = FALSE, shape = 16, size = 0.5)

  if (!is.null(stats)) {
    # Add asterisks for significant changes
    ylim <- layer_scales(p)$y$range$range

    y_pos <- x %>%
      group_by(sex, group, group_num) %>%
      summarise(y_position = max(c(pre, post), na.rm = TRUE),
                y_position = y_position + diff(ylim) * 0.05,
                .groups = "keep")

    stats <- left_join(stats, y_pos, by = c("sex", "group")) %>%
      filter(signif)

    # Asterisks marking significance
    p <- p +
      geom_point(aes(x = group_num, y = y_position),
                 data = stats, size = 3.5, color = "black",
                 shape = "*")
  }

  # Modify appearance
  p <- p +
    scale_color_manual(name = "Post - Pre:",
                       values = c("darkred", "#3366ff", "grey20"),
                       breaks = c("Increase", "Decrease", "No Change"),
                       limits = c("Increase", "Decrease", "No Change")) +
    scale_x_continuous(name = NULL,
                       breaks = 1:nlevels(x$group),
                       labels = levels(x$group)) +
    guides(color = guide_legend(keywidth = unit(7, "pt"),
                                keyheight = unit(7, "pt"))) +
    labs(y = pre) +
    theme_minimal(base_size = 7) +
    theme(axis.text.x = element_text(size = 7, color = "black"),
          axis.text.y = element_text(size = 7, color = "black"),
          axis.title.y = element_text(size = 7, color = "black",
                                      margin = margin(r = 3, unit = "pt")),
          axis.ticks.y = element_line(color = "black"),
          axis.line = element_line(color = "black"),
          panel.grid = element_blank(),
          plot.background = element_rect(fill = "white", color = NA),
          plot.title = element_text(size = 7, hjust = 0.5),
          plot.margin = unit(c(2, 2, 2, 2), "pt"),
          legend.position = "bottom",
          legend.direction = "horizontal",
          legend.title = element_text(size = 7, color = "black"),
          legend.text = element_text(size = 7, color = "black"),
          legend.margin = margin(t = -4, b = 0, l = -18, unit = "pt"),
          strip.text = element_text(size = 7, color = "black"),
          panel.spacing = unit(3, "pt"))

  return(p)
}

