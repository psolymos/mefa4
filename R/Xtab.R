Xtab <-
function(formula = ~., data = parent.frame(),
rdrop, cdrop,
subset, na.action, exclude = c(NA, NaN), drop.unused.levels = FALSE)
{
    ## this code is taken from Matrix::xtabs
    ## and modified by P Solymos

    ## cannott use only data, formula is needed
    if (missing(formula))
        stop("must supply 'formula'")
    if (!missing(formula)) {
        formula <- as.formula(formula)
        if (!inherits(formula, "formula"))
            stop("'formula' missing or incorrect")
    }
    if (any(attr(terms(formula, data = data), "order") > 1))
        stop("interactions are not allowed")
    m <- match.call(expand.dots = FALSE)
    if (is.matrix(eval(m$data, parent.frame())))
        m$data <- as.data.frame(data)
    m$... <- m$exclude <- m$drop.unused.levels <- m$sparse <- NULL
    m$rdrop <- m$cdrop <- NULL
    m[[1]] <- as.name("model.frame")
    mf <- eval(m, parent.frame())
    if (length(formula) == 2) {
        by <- mf
        y <- NULL
    }
    else {
        i <- attr(attr(mf, "terms"), "response")
        by <- mf[-i]
        y <- mf[[i]]
    }
    by <- lapply(by, function(u) {
        if (!is.factor(u))
            u <- factor(u, exclude = exclude)
        u[, drop = drop.unused.levels]
    })
#    if (length(by) != 2)
#        stop("function applies only to two-way tables")
    if (!(length(by) %in% 2:3))
        stop("function applies only to two- or three-way tables")
    rows <- by[[1]]
    cols <- by[[2]]
    rl <- levels(rows)
    cl <- levels(cols)
    if (is.null(y))
        y <- rep.int(1, length(rows))
    if (!is.numeric(y))
        stop("lhs of formula not numeric")
    ## this is how it is constructed, then converted into dgCMatrix
    out <- as(new("dgTMatrix",
        i = as.integer(rows) - 1L,
        j = as.integer(cols) - 1L,
        x = as.double(y),
        Dim = c(length(rl), length(cl)),
        Dimnames = list(rl, cl)), "CsparseMatrix")
    rkeep <- 1:nrow(out)
    ckeep <- 1:ncol(out)
    if (!missing(rdrop)) {
        if (is.logical(rdrop)) {
            if (rdrop)
                rkeep <- which(rowSums(out) > 0)
        } else if (is.numeric(rdrop)) {
            rkeep <- setdiff(rkeep, rdrop)
        } else if (is.character(rdrop)) {
            rkeep <- setdiff(rownames(out), rdrop)
        } else stop("inappropriate 'rdrop' value")
    }
    if (!missing(cdrop)) {
        if (is.logical(cdrop)) {
            if (cdrop)
                ckeep <- which(colSums(out) > 0)
        } else if (is.numeric(cdrop)) {
            ckeep <- setdiff(ckeep, cdrop)
        } else if (is.character(cdrop)) {
            ckeep <- setdiff(colnames(out), cdrop)
        } else stop("inappropriate 'cdrop' value")
    }
    if (length(by) == 2) {
        out <- out[rkeep, ckeep, drop=FALSE]
        out <- drop0(out)
        out <- as(out, "dgCMatrix")
    }
    if (length(by) == 3) {
        segm <- by[[3]]
        sl <- levels(segm)
        out <- vector("list", length(sl))
        names(out) <- sl
        for (i in 1:length(sl)) {
            id <- which(as.integer(segm) == i)
            out[[sl[i]]] <- as(new("dgTMatrix",
                i = as.integer(rows[id]) - 1L,
                j = as.integer(cols[id]) - 1L,
                x = as.double(y[id]),
                Dim = c(length(rl), length(cl)),
                Dimnames = list(rl, cl)), "CsparseMatrix")
            out[[sl[i]]] <- out[[sl[i]]][rkeep, ckeep, drop=FALSE]
            out[[sl[i]]] <- drop0(out[[sl[i]]])
        }
#        class(out) <- "sparseMatrixList"
    }
    out
}
