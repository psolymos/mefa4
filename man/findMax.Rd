\name{find_max}
\alias{compare_sets}
\alias{find_max}
\alias{find_min}
\alias{reclass}
\title{
Utility functions for factors and compositional data
}
\description{
Utility functions for factors and compositional data.
}
\usage{
compare_sets(x, y)
find_max(x)
find_min(x)
reclass(x, map, all = FALSE)
}
\arguments{
  \item{x, y}{
any type for \code{compare_sets},
matrix for \code{find_max} and \code{find_min},
a factor for \code{reclass}.
}
  \item{map}{
a reclassification matrix with 2 columns (1st: original levels,
2nd: output levels mapped to original levels).
}
  \item{all}{
logical, whether all levels from mapping matrix should be
applied on the return object.
}
}
\value{
A matrix \code{compare_sets}.

A data frame for \code{find_max} and \code{find_min}.

A reclassified factor for \code{reclass}.
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
\code{\link{intersect}}, \code{\link{setdiff}},
\code{\link{union}}, \code{\link{relevel}}, \code{\link{reorder}}
}
\examples{
## numeric vector
compare_sets(1:10, 8:15)
## factor with 'zombie' labels
compare_sets(factor(1:10, levels=1:10), factor(8:15, levels=1:15))

(mat <- matrix(rnorm(10*5), 10, 5))
(m <- find_max(mat))
## column indices
as.integer(m$index)
find_min(mat)

map <- cbind(c("a","b","c","d","e","f","g"),
             c("A","B","B","C","D","D","E"))
#x <- factor(sample(map[1:6,1], 100, replace=TRUE), levels=map[,1])
x <- as.factor(sample(map[1:6,1], 100, replace=TRUE))
x[2] <- NA
table(x, reclass(x, map, all = FALSE), useNA="always")
table(x, reclass(x, map, all = TRUE), useNA="always")

}
\keyword{ manip }

