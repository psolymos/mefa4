find_max <- function(x) {
    if (is.null(dim(x)))
        stop("x must be matrix like object with dim attribute")
    if (is.null(colnames(x)))
        colnames(x) <- paste0("X", seq_len(ncol(x)))
    m <- ncol(x)
    idx <- integer(nrow(x))+1L
    val <- x[,1L]
    for (j in seq_len(m)[-1L]) {
        s <- x[,j] > val
        val[s] <- x[s,j]
        idx[s] <- j
    }
    i <- factor(idx, levels = seq_len(m))
    levels(i) <- colnames(x)
    out <- data.frame(index = i, value = val)
    rownames(out) <- rownames(x)
    out
}
