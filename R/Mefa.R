Mefa <-
function(xtab, samp, taxa,
join = c("left", "inner"), drop = FALSE) {
    if (missing(xtab))
        stop("'xtab' must be supplied")
    if (is.null(dimnames(xtab))) {
        dimnames(xtab) <- list(1:nrow(xtab), 1:ncol(xtab))
        warnings("dimnames for 'xtab' added, it was NULL")
    }
    if (missing(samp)) {
        samp <- NULL
        sid <- rownames(xtab)
    } else sid <- rownames(samp)
    if (missing(taxa)) {
        taxa <- NULL
        tid <- colnames(xtab)
    } else tid <- rownames(taxa)
    xrid <- rownames(xtab)
    xcid <- colnames(xtab)
    join <- match.arg(join)
    if (join == "left") {
        rkeep <- xrid
        ckeep <- xcid
    }
    if (join == "inner") {
        rkeep <- if (!is.null(samp))
            intersect(xrid, sid) else xrid
        ckeep <- if (!is.null(taxa))
            intersect(xcid, tid) else xcid
    }
    xtab <- xtab[rkeep, ckeep, drop=FALSE]
    if (!is.null(samp)) {
        samp <- samp[rkeep,,drop=FALSE]
        rownames(samp) <- rkeep
    }
    if (!is.null(taxa)) {
        taxa <- taxa[ckeep,,drop=FALSE]
        rownames(taxa) <- ckeep
    }
    if (drop) {
        samp[] <- lapply(samp, function(z) z[drop = TRUE])
        taxa[] <- lapply(taxa, function(z) z[drop = TRUE])
    }
    new("Mefa",
        xtab = as(xtab, "dgCMatrix"),
        samp = samp, taxa = taxa,
        join = join)
}
