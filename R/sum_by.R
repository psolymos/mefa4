sum_by <- function(x, by) {
    mm <- as(factor(by, levels=unique(by)), "sparseMatrix")
    cbind(x=as.numeric(mm %*% x), by=rowSums(mm))
}
