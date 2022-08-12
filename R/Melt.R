Melt <-
function(x)
{
    if (inherits(x, "Mefa"))
        x <- x@xtab
    if (inherits(x, "mefa"))
        # x <- as(x$xtab, "dgCMatrix")
        x <- as(as(as(x$xtab, "dMatrix"), "generalMatrix"), "CsparseMatrix")
    if (inherits(x, "matrix"))
        # x <- as(x, "dgCMatrix")
        x <- as(as(as(x, "dMatrix"), "generalMatrix"), "CsparseMatrix")
    if (inherits(x, "sparseMatrix")) {
        if (is.null(rownames(x)))
            stop("missing row names")
        if (is.null(colnames(x)))
            stop("missing column names")
        # x <- as(x, "dgTMatrix")
        x <- as(as(as(x, "dMatrix"), "generalMatrix"), "TsparseMatrix")
        rows <- x@i + 1L
        cols <- x@j + 1L
        y <- x@x
        out <- data.frame(
            rows = factor(x@Dimnames[[1]][rows],
                levels=unique(x@Dimnames[[1]])),
            cols = factor(x@Dimnames[[2]][cols],
                levels=unique(x@Dimnames[[2]])),
            value = y)
    } else if (is.list(x) && all(sapply(x, function(z)
        inherits(z, "sparseMatrix")))) {
        if (!all(sapply(x[-1], function(z)
            identical(z@Dimnames, x[[1]]@Dimnames))))
            stop("dimnames of list elements must be identical")
        n <- length(x)
        X <- rows <- cols <- y <- vector("list", n)
        for (k in 1:n) {
            # X[[k]] <- as(x[[k]], "dgTMatrix")
            X[[k]] <- as(as(as(x[[k]], "dMatrix"), "generalMatrix"), "TsparseMatrix")
            rows[[k]] <- X[[k]]@i + 1L
            cols[[k]] <- X[[k]]@j + 1L
            y[[k]] <- X[[k]]@x
        }
        out <- data.frame(
            rows = factor(x[[1]]@Dimnames[[1]][unlist(rows)],
                levels=unique(x[[1]]@Dimnames[[1]])),
            cols = factor(x[[1]]@Dimnames[[2]][unlist(cols)],
                levels=unique(x[[1]]@Dimnames[[2]])),
            segm = as.factor(rep(names(x), sapply(y, length))),
            value = unlist(y))
    } else stop("object class not appropriate")
    out
}
