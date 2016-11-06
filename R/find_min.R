find_min <- function(x) {
    out <- find_max(-1 * x)
    out$value <- -1 * out$value
    out
}
