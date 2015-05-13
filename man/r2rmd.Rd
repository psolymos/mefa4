\name{r2rmd}
\alias{r2rmd}
\title{
Parse R source file and return R markdown
}
\description{
Parses an R source file and returns an R markdown document that
can be turned into a human readable documentation of what the source file does.
}
\usage{
r2rmd(file, out=paste(file, "md", sep=""), header=TRUE, extra)
}
\arguments{
  \item{file}{
a file name or connection (see \code{\link{readLines}}.
}
  \item{out}{
an output file name passed to \code{\link{writeLines}},
or \code{NULL} (no file written).
}
  \item{header}{
logical, if a yaml header (enclosed between tribple dashes, \code{---})
is to be parsed.
}
  \item{extra}{
character, optional string that is placed into the code chunk openings.
}
}
\details{
Leading double hashes \code{##} treated as non-code.
Leading \code{#} followed by other than \code{#} is code comment.
Leading \code{#} after whitespace is code comment.
A newline is code when preceded and followed by code.

The leading double hash \code{##} is trimmed for comment lines.
R markdown chunk start/end stuff is added for code chunks.
The argument \code{extra} adds chunk arguments, e.g. 
\code{extra=', eval=FALSE'} etc. See R markdown website at 
\url{http://rmarkdown.rstudio.com/}
}
\value{
Returns a character vector invisibly, and writes a file as a side effects 
unless \code{out=NULL} in which case no file is written.
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
\url{http://rmarkdown.rstudio.com/}
}
\examples{
\dontrun{
(r2rmd(system.file("r2rmd_example.R", package="mefa4"), 
    out=NULL, extra=", eval=FALSE"))
}
}
\keyword{ manip }
\keyword{ IO }
