#' @title Plot LMM or GLS diagnostic plots
#' @title Linear mixed model diagnostic plots
#'
#' @importFrom stats resid fitted loess.smooth qqnorm qqline
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
