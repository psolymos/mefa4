setGeneric("groupMeans", function(object, ...) standardGeneric("groupMeans"))

setMethod("groupMeans", "sparseMatrix", function(object, MARGIN, by, na.rm = FALSE, ...) {
    x <- groupSums(object, MARGIN, by, na.rm, ...)
    if (any(is.na(x))) {
        n <- groupSums(as(!is.na(object), "sparseMatrix"), MARGIN, by, na.rm, ...)
        out <- x / n
    } else {
        n <- rowSums(as(factor(by, levels=unique(by)), "sparseMatrix"))
        out <- if (MARGIN == 1)
            x / n else t(t(x) / n)
    }
    as(out, "sparseMatrix")
})
setMethod("groupMeans", "matrix", function(object, MARGIN, by, na.rm = FALSE, ...) {
    as.matrix(groupMeans(as(object, "sparseMatrix"), MARGIN, by, na.rm, ...))
})
setMethod("groupMeans", "Mefa", function(object, MARGIN, by, replace, na.rm = FALSE, ...) {
    x <- groupMeans(as(object, "sparseMatrix"), MARGIN, by, na.rm, ...)
    if (missing(replace))
        replace <- NULL
    JOIN <- object@join
    if (MARGIN == 2) {
#        if (is.null(object@samp) && is.null(replace))
#            JOIN <- "inner"
        new("Mefa", xtab = x, samp = object@samp,
            taxa = replace, join = JOIN)
    } else {
#        if (is.null(object@taxa) && is.null(replace))
#            JOIN <- "inner"
        new("Mefa", xtab = x, samp = replace,
            taxa = object@taxa, join = JOIN)
    }
})
