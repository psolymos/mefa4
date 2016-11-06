setGeneric("groupSums", function(object, ...) standardGeneric("groupSums"))

## MARGIN indicates what to group (1: group rows, 2: group cols)
setMethod("groupSums", "matrix", function(object, MARGIN, by, na.rm = FALSE, ...) {
    if (any(is.na(by)))
        stop("'NA' not allowed in 'by'")
    if (any(is.na(object)) && !na.rm)
        stop("'NA' found in 'object'")
    if (!(MARGIN %in% 1:2))
        stop("'MARGIN' must be in 1:2")
    if (length(MARGIN) != 1)
        stop("MARGIN = 1:2 not yet implemented")
    if (length(by) != dim(object)[MARGIN])
        stop("Non conforming 'object', 'MARGIN' and 'by'")
    mm <- as(factor(by, levels=unique(by)), "sparseMatrix")
    rownames(mm) <- unique(by)
    object <- as(object, "sparseMatrix")
    if (na.rm)
        object[is.na(object)] <- 0
    if (MARGIN == 2) {
        out <- t(mm %*% t(object))
    } else {
        out <- mm %*% object
    }
    as.matrix(out)
})
setMethod("groupSums", "sparseMatrix", function(object, MARGIN, by, na.rm = FALSE, ...) {
    if (any(is.na(by)))
        stop("'NA' not allowed in 'by'")
    if (any(is.na(object)) && !na.rm)
        stop("'NA' found in 'object'")
    if (!(MARGIN %in% 1:2))
        stop("'MARGIN' must be in 1:2")
    if (length(MARGIN) != 1)
        stop("MARGIN = 1:2 not yet implemented")
    if (length(by) != dim(object)[MARGIN])
        stop("Non conforming 'object', 'MARGIN' and 'by'")
    mm <- as(factor(by, levels=unique(by)), "sparseMatrix")
    rownames(mm) <- unique(by)
    if (na.rm)
        object[is.na(object)] <- 0
    if (MARGIN == 2) {
        out <- t(mm %*% t(object))
    } else {
        out <- mm %*% object
    }
    out
})
## replace is a replacement object for the affected non xtab slot (samp, taxa)
setMethod("groupSums", "Mefa", function(object, MARGIN, by, replace, na.rm = FALSE, ...) {
    x <- groupSums(object@xtab, MARGIN, by, na.rm, ...)
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
