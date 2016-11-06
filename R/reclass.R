reclass <- function (x, map, all = FALSE) {
    if (is.null(dim(map)))
        stop("map argument must be matrix-like object")
    if (ncol(map) != 2L)
        stop("map must have 2 columns")
    if (!is.factor(x))
        x <- as.factor(x)
    if (any(is.na(map)))
        stop("NA found in map")
    map <- as.matrix(map)
    if (storage.mode(map) != "character")
        storage.mode(map) <- "character"
    if (any(duplicated(map[,1L])))
        stop("values in 1st column in map must be unique")
    if (any(!(levels(x) %in% map[,1L])))
        stop("levels of x must be all part of map[,1]")
    if (all)
        levels(x) <- c(levels(x), setdiff(map[,1L], levels(x)))
    levels(x) <- map[match(levels(x), map[,1L]),2]
    x
}
