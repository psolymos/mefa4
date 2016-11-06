compare_sets <- function(x, y) {
    x <- as.factor(x)
    y <- as.factor(y)
    xl <- levels(x)
    yl <- levels(y)
    xa <- levels(droplevels(x))
    ya <- levels(droplevels(y))
    lab <- c(xlength=length(xl), ylength=length(yl),
        intersect=length(intersect(xl, yl)),
        union=length(union(xl, yl)),
        xbutnoty=length(setdiff(xl, yl)),
        ybutnotx=length(setdiff(yl, xl)))
    act <- c(xlength=length(xa), ylength=length(ya),
        intersect=length(intersect(xa, ya)),
        union=length(union(xa, ya)),
        xbutnoty=length(setdiff(xa, ya)),
        ybutnotx=length(setdiff(ya, xa)))
    rbind(labels=lab, unique=act)
}
