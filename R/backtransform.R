#' Backtransform Scaled Predictors
#'
#' Backtransform scaled predictors in \code{novelforest_data} to their
#' original scales. This is done by first back-scaling to the log-scale, and
#' then backtranformed to the original scale (the predictors were
#' log-transformed as described in Lai et al. 2021).
#'
#' @param data Defaults to the data object in \code{novelforest}, but could
#' also be another \code{data.frame} with the same predictor names, should you wish to
#' (back)scale and (back)center using the same means and standard deviations for
#' any reason.
#'
#' @return A backtransformed \code{data.frame} with predictors at their original scales.
#'
#' @references Lai, H.R., Tan, G.S.Y., Neo, L., Kee, C.Y., Yee, A.T.K., Tan, H.T.W.
#' and Chong, K.Y. (2021) Decoupled responses of native and exotic tree
#' diversities to distance from old-growth forest and soil phosphorous in
#' novel secondary forests. *Applied Vegetation Science*, 24, e12548.
#' \doi{10.1111/avsc.12548}
#'
#' @export
#'
#' @examples
#' # argument could be left blank
#' dat <- backtransform()
#' head(dat)

backtransform <- function(data = novelforest_data) {
    # retrieve scales and centers
    vars    <- scales_centers$X
    scales  <- scales_centers$SD
    centers <- scales_centers$Mean

    out <- data
    # backscale
    out[, vars] <- sweep(out[, vars], 2, scales, "*")
    out[, vars] <- sweep(out[, vars], 2, centers, "+")
    # backtransform
    out[, vars] <- exp(out[, vars])

    return(out)
}
