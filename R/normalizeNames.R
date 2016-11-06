normalizeNames <-
function(x, pattern=list(" "), replacement=list("_"), alnum = FALSE, ...)
{
    if (!is.factor(x))
        x <- as.character(x)
    l0 <- if (is.factor(x))
        levels(x) else unique(x)
    l <- l0
    if (length(pattern) != length(replacement))
        stop("pattern and replacement lengths must be equal")
    pattern <- as.list(pattern)
    replacement <- as.list(replacement)
    for (i in seq_len(length(pattern))) {
        l <- gsub(as.character(pattern[[i]]), as.character(replacement[[i]]),
            l, fixed=TRUE)
    }
    if (alnum)
        l <- nameAlnum(l, ...)
    if (is.factor(x)) {
        levels(x) <- l
    } else {
        x <- l[match(x, l0)]
    }
    x
}
