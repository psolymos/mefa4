\name{nameAlnum}
\alias{nameAlnum}
\alias{pasteDate}
\alias{paste0date}
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
}
\arguments{
  \item{x}{
caharacter.
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
    NameAlnum=nameAlnum(levels(abmibirds[["Common.Name"]])),
    stringsAsFactors = TRUE)
x[grep("'", x$Name),]

data.frame(out=sapply(c("asis", "first", "none", "all", "mixed"),
    function(z) nameAlnum("Olive-sided Flycatcher", z)),
    stringsAsFactors = TRUE)

z <- data.frame(Name=levels(abmibirds[["Common.Name"]]),
    NameNormalized=normalizeNames(levels(abmibirds[["Common.Name"]]),
        pattern=list("'", "-", " "), replacement=list("", "_", "_")),
    stringsAsFactors = TRUE)
z[grepl("'", z$Name) & grepl("-", z$Name),]
}
\keyword{ manip }

