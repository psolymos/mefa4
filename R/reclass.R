reclass <-
function (x, map, all = FALSE, allow_NA = FALSE)
{
    if (is.null(dim(map)))
        stop("map argument must be matrix-like object")
    if (ncol(map) != 2L)
        stop("map must have 2 columns")
    if (!is.factor(x))
        x <- as.factor(x)
    if (any(is.na(map)) && !allow_NA)
        stop("NA found in map and not allowed")
    map <- data.frame(map)
    map[[1L]] <- as.character(map[[1L]])
    map[[2L]] <- as.character(map[[2L]])
    if (any(duplicated(map[[1L]])))
        stop("values in 1st column in map must be unique")
    if (any(!(levels(x) %in% map[[1]][!is.na(map[[1L]])])))
        stop("levels of x must be all part of map[,1]")
    if (all)
        levels(x) <- c(levels(x),
            setdiff(map[[1L]][!is.na(map[[1L]])], levels(x)))
    levels(x) <- map[match(levels(x), map[[1L]]), 2]
    x
}
