find_max <- function(x) {
    if (is.null(dim(x)))
        stop("x must be matrix like object with dim attribute")
    if (is.null(colnames(x)))
        colnames(x) <- paste0("X", seq_len(ncol(x)))
    tmp <- pbapply(x, 1, function(z) {
        i <- which.max(z)
        if (length(i))
            c(i, z[i]) else c(NA, NA)
    })
    i <- factor(tmp[1, ], levels = seq_len(ncol(x)))
    levels(i) <- colnames(x)
    out <- data.frame(index = i, value = tmp[2, ])
    rownames(out) <- rownames(x)
    out
}
