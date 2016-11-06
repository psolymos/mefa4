setGeneric("mbind2", function(x, y, fill, ...) standardGeneric("mbind2"))

setMethod("mbind2", signature(x="matrix", y="matrix", fill="ANY"),
    function(x, y, fill, ...) {
        as.matrix(mbind2(x=as(x, "sparseMatrix"),
            y=as(y, "sparseMatrix"),
            fill=fill, ...))
})

setMethod("mbind2", signature(x="sparseMatrix", y="sparseMatrix", fill="ANY"),
    function(x, y, fill, ...) {
        if (missing(fill))
            fill <- NA
        if (length(x) == 0)
            stop("length of 'x' must not be 0")
        if (length(y) == 0)
            stop("length of 'y' must not be 0")
        if (is.null(dimnames(x)))
            stop("dimnames of 'x' must not be NULL")
        if (is.null(dimnames(y)))
            stop("dimnames of 'y' must not be NULL")
        rn <- union(rownames(x), rownames(y))
        cn <- union(colnames(x), colnames(y))
        rn0 <- intersect(rownames(x), rownames(y))
        cn0 <- intersect(colnames(x), colnames(y))
        out <- Matrix(fill,
            length(rn), length(cn),
            dimnames=list(rn, cn),
            sparse=TRUE)
        out <- as(out, "dgCMatrix")
        out[rownames(x), colnames(x)] <- x
        out[rownames(y), colnames(y)] <- y
        out[rn0, cn0] <- x[rn0, cn0] + y[rn0, cn0]
        out
})
