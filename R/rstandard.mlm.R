#' @title rstandard method for "mlm" class
#'
#' @param model an \code{"mlm"} ("multivariate linear model") object. See
#'   \code{\link[stats]{lm}} for details.
#'
#'
#' @source \url{https://stackoverflow.com/a/39768104}
#'
#' @importFrom stats weights
#'
#' @export rstandard.mlm


rstandard.mlm <- function(model) {
  # Q matrix
  Q <- with(model, qr.qy(qr, diag(1, nrow = nrow(qr$qr), ncol = qr$rank)))

  # Weights
  if (is.null(weights(model))) {
    w <- rep(1, nrow(Q))
  } else {
    w <- weights(model)
  }
  rw <- sqrt(w)

  # Hat matrix
  Q1 <- (1 / rw) * Q
  Q2 <- rw * Q

  # diagonal of hat matrix Q1Q2'
  hii <- rowSums(Q1 * Q2)
  # residual sums of squares for each model
  RSS <- colSums(model$residuals ^ 2)
  # Pearson estimate of residuals for each model
  sigma <- sqrt(RSS / model$df.residual)
  # point-wise residual standard error for each model
  pointwise_sd <- outer(sqrt(1 - hii), sigma)

  return(model$residuals / pointwise_sd)  # standardized residuals
}

