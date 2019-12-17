redistribute <- function(x, source, target=NULL) {
    if (is.null(dim(x)) || length(dim(x)) != 2L)
        stop("x must have 2 dimensions")
    if (any(x < 0))
        warning("negative values in x: results might not be meaningful")
    i <- if (is.numeric(source))
        source else which(colnames(x) == source)
    if (is.null(target)) {
        target <- seq_len(ncol(x))
        target <- target[target != i]
    }
    j <- if (is.numeric(target))
        target else match(target, colnames(x))
    if (any(is.na(j)))
        stop("target must not lead to NA column indices")
    if (i %in% j)
        stop("source must not be part of target")
    m <- x[, j, drop = FALSE]
    rs <- rowSums(m)
    rs[is.na(rs)] <- 1
    x[, j] <- m + x[, i] * m/rs
    x[, i] <- 0
    x
}
