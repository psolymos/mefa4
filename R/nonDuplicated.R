nonDuplicated <- function(x, y, change.rownames=FALSE, na.rm=FALSE) {
    if (length(dim(x)) != 2)
        stop("'x' must have 2 dimensions")
    z <- deparse(substitute(y))
    if (z %in% colnames(x))
        y <- x[,z]
    if (nrow(x) != length(y))
        stop("non matching arguments 'x' and 'y'")
    keep <- !duplicated(y)
    out <- x[keep,]
    if (na.rm) {
        y <- y[keep]
        out <- out[!is.na(y),]
        y <- y[!is.na(y)]
    } else {
        y <- y[keep]
    }
    if (change.rownames)
        rownames(out) <- y
    out
}
