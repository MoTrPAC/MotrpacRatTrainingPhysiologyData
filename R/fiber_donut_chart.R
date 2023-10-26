#' @title Muscle fiber percentage donut charts
#'
#' @description Donut charts of mean fiber type percentages.
#'
#' @param x a \code{data.frame} with columns \code{"group"} ("SED", "8W"),
#'   \code{"type"} ("I", "IIa", "IIx", "IIb"), and \code{"fiber_count"}
#'   (numeric).
#'
#' @return A \code{ggplot2} object.
#'
#' @details Fiber counts are summed across the biological replicates for each
#'   combination of group (SED, 8W) and fiber type (I, IIa, IIx, IIb). Then,
#'   each of these summed counts are divided by the total fiber count for that
#'   group and multiplied by 100 to obtain percentages.
#'
#' @importFrom dplyr %>% group_by summarise mutate ungroup
#' @importFrom ggplot2 ggplot aes geom_bar geom_text position_stack
#'   coord_cartesian coord_polar facet_wrap scale_fill_manual theme_void theme
#'   element_blank element_text
#' @importFrom grid unit
#'
#' @export fiber_donut_chart

fiber_donut_chart <- function(x)
{
  colors <- c("I" = "#75281C",
              "IIa" = "#F79485",
              "IIx" = "#FF5454",
              "IIb" = "#796C6A")

  # Prevent "no visible binding for global variable" notes.
  fiber_count <- total_fiber_count <- fiber_pct <- NULL

  x <- x %>%
    group_by(group, type) %>%
    summarise(fiber_count = sum(fiber_count)) %>%
    group_by(group) %>%
    mutate(total_fiber_count = sum(fiber_count),
           fiber_pct = 100 * fiber_count / total_fiber_count) %>%
    ungroup()

  # Stacked bar graphs
  p <- ggplot(x, aes(x = 2, y = fiber_pct, fill = type)) +
    geom_bar(stat = "identity", width = 1, color = "white")

  # Label percentages (no % sign to save space - include in main figure legend)
  p <- p +
    geom_text(aes(label = round(fiber_pct, 1),
                  x = 2.5 * 1.15),
              position = position_stack(vjust = 0.5),
              size = 7 / .pt)

  # Label donut holes with the group
  p <- p +
    geom_text(aes(x = 1, y = 0, label = group),
              data = x, size = 7 / .pt)

  # workaround to avoid warning messages
  cart <- coord_cartesian(clip = "off", xlim = c(1, 2.5))
  cart$default <- TRUE

  # Set axis limits (cartesian only) and then switch to polar coordinates to
  # convert stacked bars to donuts
  p <- p +
    cart +
    coord_polar("y", start = 0, direction = -1)

  # Modify appearance
  p <- p +
    facet_wrap(~ group, ncol = 1) +
    scale_fill_manual(name = "Type", values = colors) +
    theme_void() +
    theme(strip.text = element_blank(),
          panel.spacing.y = unit(-4, "pt"),
          legend.position = "none",
          legend.title = element_text(size = 7, color = "black"),
          legend.text = element_text(size = 7, color = "black"),
          legend.key.size = unit(10, "pt"))

  return(p)
}
