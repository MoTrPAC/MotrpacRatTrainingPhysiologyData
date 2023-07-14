#' @title Show all regression diagnostic plots
#'
#' @param model output of \code{lm} or \code{glm}.
#'
#' @importFrom graphics par
#'
#' @export plot_lm

plot_lm <- function(model) {
  par(mfrow = c(2, 3))
  for (i in 1:6) plot(model, which = i)
  par(mfrow = c(1, 1))
}
