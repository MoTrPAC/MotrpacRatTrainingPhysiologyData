#' @title Plot tissue dissection times
#'
#' @description Plot the tissue dissection times. This is the amount of time
#'   elapsed between tissue collection and freezing or death and freezing (if
#'   tissue collection was performed post-mortem).
#'
#' @param x \code{data.frame} of dissection times.
#' @param ymax numeric; upper bound on y-axis (in minutes).
#'
#' @import ggplot2
#' @importFrom dplyr %>% mutate
#' @importFrom scales label_time
#'
#' @export plot_dissection_times

plot_dissection_times <- function(x, ymax = 12) {
  x <- x %>%
    droplevels.data.frame() %>%
    mutate(color = ifelse(aliquotdescription %in%
                            c("Gastrocnemius", "White Adipose", "Liver",
                              "Vena Cava", "Lung", "Heart", "Hypothalamus",
                              "Hippocampus"),
                          "anesthesia", "death"))

  # Mean +/- 2 SD
  p <- ggplot(x, aes(x = aliquotdescription, y = t_diff, color = color)) +
    stat_summary(geom = "crossbar", fatten = 1, linewidth = 0.5,
                 fun.data = ~ exp(mean_sdl(log(.x), mult = 2)),
                 width = 0.8)

  # Modify appearance
  p <- p +
    scale_y_time(name = "Time Elapsed (min:sec)",
                 labels = scales::label_time(format = "%M:%S"),
                 expand = expansion(mult = 1e-2)) +
    labs(x = NULL) +
    coord_cartesian(ylim = c(0, ymax * 60)) +
    # light blue for tissues collected under anesthesia, grey for tissues
    # collected post-mortem
    scale_color_manual(values = c("#89CFF0", "grey50"),
                       labels = c("Under Anesthesia", "Post-Mortem")) +
    theme_minimal(base_size = 7, base_line_size = 0.3) +
    theme(axis.text = element_text(size = 7, color = "black"),
          axis.text.x = element_text(angle = 60, hjust = 1, vjust = 1),
          axis.title = element_text(size = 7.5, color = "black"),
          legend.position = "none",
          panel.grid.minor = element_blank(),
          panel.grid.major.y = element_blank(),
          axis.line = element_line(color = "black"),
          axis.ticks = element_line(color = "black"))

  return(p)
}

