#' @title Linear mixed model diagnostic plots
#'
#' @param model output of \code{\link[nlme]{lme}}.
#'
#' @importFrom stats resid fitted loess.smooth qqnorm qqline
#' @importFrom graphics lines
#'
#' @export plot_lme

plot_lme <- function(model) {
  r <- resid(model, type = "pearson")

  par(mfrow = c(1, 2)) # two panels side-by-side

  # Residuals vs. fitted
  plot(r ~ fitted(model),
       xlab = "Fitted Values",
       ylab = "Pearson Residuals",
       main = "Residuals vs. Fitted")
  lines(loess.smooth(x = fitted(model), y = r, degree = 2),
        lwd = 2, col = "red")

  # quantile-quantile plot
  qqnorm(r); qqline(r)
  par(mfrow = c(1, 1))
}
