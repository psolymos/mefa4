# Parse R source file and return R markdown

Parses an R source file and returns an R markdown document that can be
turned into a human readable documentation of what the source file does.

## Usage

``` r
r2rmd(file, out=paste(file, "md", sep=""), header=TRUE, extra)
```

## Arguments

- file:

  a file name or connection (see
  [`readLines`](https://rdrr.io/r/base/readLines.html).

- out:

  an output file name passed to
  [`writeLines`](https://rdrr.io/r/base/writeLines.html), or `NULL` (no
  file written).

- header:

  logical, if a yaml header (enclosed between triple dashes, `---`) is
  to be parsed.

- extra:

  character, optional string that is placed into the code chunk
  openings.

## Details

Leading double hashes `##` treated as non-code. Leading `#` followed by
other than `#` is code comment. Leading `#` after whitespace is code
comment. A newline is code when preceded and followed by code.

The leading double hash `##` is trimmed for comment lines. R markdown
chunk start/end stuff is added for code chunks. The argument `extra`
adds chunk arguments, e.g. `extra=', eval=FALSE'` etc. See R markdown
website at <https://rmarkdown.rstudio.com/>

## Value

Returns a character vector invisibly, and writes a file as a side
effects unless `out=NULL` in which case no file is written.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

<https://rmarkdown.rstudio.com/>

## Examples

``` r
if (FALSE) { # \dontrun{
(r2rmd(system.file("r2rmd_example.R", package="mefa4"), 
    out=NULL, extra=", eval=FALSE"))
} # }
```
