library(mefa4)
library(dplyr)

f1 <- function(z, s, gr=10, gc=10, what=1) {
    d <- c(z*gr, z*gc)
    ir <- rep(seq_len(gr), d[1]/gr)
    ic <- rep(seq_len(gc), d[2]/gc)
    x <- array(runif(prod(d), 0.001, 1), d)
    s <- sample.int(prod(d), floor(prod(d)*s))
    x[s] <- 0
    xx <- as(x, "dgCMatrix")
    if (what==1) {
        t1 <- system.time(groupSums(xx, 1, ir))["elapsed"]
        t2 <- system.time(aggregate(x, list(ir), sum))["elapsed"]
    }
    if (what==1) {
        t1 <- system.time(groupSums(xx, 2, ic))["elapsed"]
        t2 <- system.time(aggregate(t(x), list(ic), sum))["elapsed"]
    }
    if (what==1) {
        t1 <- system.time(groupMeans(xx, 1, ir))["elapsed"]
        t2 <- system.time(aggregate(x, list(ir), mean))["elapsed"]
    }
    if (what==1) {
        t1 <- system.time(groupMeans(xx, 2, ic))["elapsed"]
        t2 <- system.time(aggregate(t(x), list(ic), mean))["elapsed"]
    }
    c(group=t1, aggr=t2)
}

z <- seq(10, 100, by=10)
s <- seq(0, 0.8, 0.1)
vals <- expand.grid(z=z, s=s)
set.seed(1234)
r1 <- pblapply(1:nrow(vals), function(i) f1(vals[i,1], vals[i,2], 10, 10, 1))
r2 <- pblapply(1:nrow(vals), function(i) f1(vals[i,1], vals[i,2], 10, 10, 1))
r3 <- pblapply(1:nrow(vals), function(i) f1(vals[i,1], vals[i,2], 10, 10, 1))

g1 <- sapply(r1, function(z) z[1])
g2 <- sapply(r2, function(z) z[1])
g3 <- sapply(r3, function(z) z[1])
a1 <- sapply(r1, function(z) z[2])
a2 <- sapply(r2, function(z) z[2])
a3 <- sapply(r3, function(z) z[2])

m1 <- matrix(apply(cbind(g1, g2, g3), 1, min), length(z), length(s))
m2 <- matrix(apply(cbind(a1, a2, a3), 1, min), length(z), length(s))

op <- par(mfrow=c(2,1))
image(z^2, s, m1, xlab="dim", ylab="sparsity", zlim=range(m1))
contour(z^2, s, m1, add=TRUE)
image(z^2, s, m2, xlab="dim", ylab="sparsity", zlim=range(m2))
contour(z^2, s, m2, add=TRUE)
par(op)


mm1 <- t(m1)
dim(mm1) <- NULL
mm2 <- t(m2)
dim(mm2) <- NULL

plot(mm1, mm2, xlim=c(0, 0.05), ylim=c(0, 0.3),
    pch=19, col=heat.colors(9)[as.factor(s)])
abline(0,1)

summary(lm(mm1 ~ z * s, vals))
summary(lm(mm2 ~ z * s, vals))


f1(10, 0, 10, 10, 1)
f1(100, 0, 10, 10, 1)
f1(1000, 0, 10, 10, 1)
