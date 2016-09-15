\name{nameAlnum}
\alias{nameAlnum}
\alias{pasteDate}
\alias{paste0date}
\alias{compare_sets}
\alias{find_max}
\alias{find_min}
\alias{normalizeNames}
\title{
Utility functions, mostly for character manipulation
}
\description{
Utility functions, mostly for character manipulation.
}
\usage{
pasteDate(..., sep = " ", collapse = NULL, sep.date = sep)
paste0date(..., collapse = NULL)
nameAlnum(x, capitalize=c("asis", "first", "none", "all", "mixed"),
    collapse=" ")
normalizeNames(x, pattern = list(" "), replacement = list("_"),
    alnum = FALSE, ...)
compare_sets(x, y)
find_max(x)
find_min(x)
}
\arguments{
  \item{x, y}{
caharacter for \code{nameAlnum}, any type for \code{compare_sets},
matrix for \code{find_max} and \code{find_min}.
}
  \item{\dots}{
one or more R objects, to be converted to character vectors.
For \code{normalizeNames} it takes arguments passed to \code{nameAlnum}
when \code{alnum = TRUE}.
}
  \item{sep}{
a character string to separate the terms.
}
  \item{collapse}{
an optional character string to separate the results.
For \code{nameAlnum} it is the separator between the words in the output.
}
  \item{sep.date}{
a character string to separate the terms from the data itself.
}
  \item{capitalize}{
character, which letter of each words should be capitalized.
\code{"mixed"} capitalizes the first letter and case is unchanged
for the rest (CamelCase). \code{"first"} capitalizes first letter and
uses lower case for the rest. Other options are self explanatory.
}
  \item{pattern}{
a list of character vectors that are replaced.
Must match argument \code{replacement}.
}
  \item{replacement}{
a list of character vectors that are the replacements for \code{pattern}.
Must match argument \code{pattern}.
}
  \item{alnum}{
logical, if \code{nameAlnum} should be applied after replacement.
}
}
\value{
Character vector with desired changes.

A matrix \code{compare_sets}.

A data frame for \code{find_max} and \code{find_min}.
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
\code{\link{paste}}, \code{\link{paste0}},
\code{\link{strsplit}}, \code{\link{gsub}}
}
\examples{
paste0(pasteDate("file", "name", sep="-", sep.date="_"), ".csv")
paste0(paste0date("file", "name", sep.date="_"), ".csv")

data(abmibirds)
x <- data.frame(Name=levels(abmibirds[["Common.Name"]]),
    NameAlnum=nameAlnum(levels(abmibirds[["Common.Name"]])))
x[grep("'", x$Name),]

z <- data.frame(Name=levels(abmibirds[["Common.Name"]]),
    NameNormalized=normalizeNames(levels(abmibirds[["Common.Name"]]),
        pattern=list("'", "-", " "), replacement=list("", "_", "_")))
z[grepl("'", z$Name) & grepl("-", z$Name),]

## numeric vector
compare_sets(1:10, 8:15)
## factor with 'zombie' labels
compare_sets(factor(1:10, levels=1:10), factor(8:15, levels=1:15))

(mat <- matrix(rnorm(10*5), 10, 5))
(m <- find_max(mat))
## column indices
as.integer(m$index)
find_min(mat)
}
\keyword{ manip }

