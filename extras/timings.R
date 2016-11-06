library(mefa4)
library(dplyr)

f1 <- function(z, s, gr=10, gc=10) {
    d <- c(z*gr, z*gc)
    ir <- rep(seq_len(gr), d[1]/gr)
    ic <- rep(seq_len(gc), d[2]/gc)
    x <- array(runif(prod(d), 0.001, 1), d)
    s <- sample.int(prod(d), floor(prod(d)*s))
    x[s] <- 0
    x <- as(x, "dgCMatrix")

    t1 <- system.time(y1 <- groupSums(x, 1, ir))
    t2 <- system.time(y2 <- groupSums(x, 2, ic))
    t3 <- system.time(y3 <- groupMeans(x, 1, ir))
    t4 <- system.time(y4 <- groupMeans(x, 2, ic))

    rbind(row_sum=t1, col_sum=t1, row_mean=t3, col_mean=t4)
}

z <- 1:10*10
s <- seq(0, 0.8, 0.1)
vals <- expand.grid(z=z, s=s)
r1 <- lapply(1:nrow(vals), function(i) f1(vals[i,1], vals[i,2], 10, 10))

elap <- t(sapply(r1, function(z) z[,"elapsed"]))

m <- matrix(rowMeans(elap), length(z), length(s))
image(z, s, m, xlab="dim", ylab="sparsity")
contour(z, s, m, add=TRUE)
