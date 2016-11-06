nameAlnum <-
function(x, capitalize=c("asis", "first", "none", "all", "mixed"), collapse=" ")
{
    capitalize <- match.arg(capitalize)
    .capwords <- function(x) {
        s <- strsplit(x, " ")[[1]]
        paste(toupper(substring(s, 1, 1)), substring(s, 2),
              sep = "", collapse = " ")
    }
    capwords <- function(x) sapply(x, .capwords)
    if (capitalize == "first") {
        x <- tolower(x)
        capitalize <- "mixed"
    }
    f <- switch(capitalize,
        "asis"=function(x) return(x),
        "mixed"=capwords,
        "none"=tolower,
        "all"=toupper)
    sapply(x, function(z) {
        paste0(f(strsplit(gsub("[^[:alnum:] ]", "", z), " +")[[1]]), collapse=collapse)
    }, USE.NAMES = !is.null(names(x)))
}
