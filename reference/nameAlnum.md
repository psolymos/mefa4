# Utility functions, mostly for character manipulation

Utility functions, mostly for character manipulation.

## Usage

``` r
pasteDate(..., sep = " ", collapse = NULL, sep.date = sep)
paste0date(..., collapse = NULL)
nameAlnum(x, capitalize=c("asis", "first", "none", "all", "mixed"),
    collapse=" ")
normalizeNames(x, pattern = list(" "), replacement = list("_"),
    alnum = FALSE, ...)
```

## Arguments

- x:

  caharacter.

- ...:

  one or more R objects, to be converted to character vectors. For
  `normalizeNames` it takes arguments passed to `nameAlnum` when
  `alnum = TRUE`.

- sep:

  a character string to separate the terms.

- collapse:

  an optional character string to separate the results. For `nameAlnum`
  it is the separator between the words in the output.

- sep.date:

  a character string to separate the terms from the data itself.

- capitalize:

  character, which letter of each words should be capitalized. `"mixed"`
  capitalizes the first letter and case is unchanged for the rest
  (CamelCase). `"first"` capitalizes first letter and uses lower case
  for the rest. Other options are self explanatory.

- pattern:

  a list of character vectors that are replaced. Must match argument
  `replacement`.

- replacement:

  a list of character vectors that are the replacements for `pattern`.
  Must match argument `pattern`.

- alnum:

  logical, if `nameAlnum` should be applied after replacement.

## Value

Character vector with desired changes.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

[`paste`](https://rdrr.io/r/base/paste.html),
[`paste0`](https://rdrr.io/r/base/paste.html),
[`strsplit`](https://rdrr.io/r/base/strsplit.html),
[`gsub`](https://rdrr.io/r/base/grep.html)

## Examples

``` r
paste0(pasteDate("file", "name", sep="-", sep.date="_"), ".csv")
#> [1] "file-name_2026-04-25.csv"
paste0(paste0date("file", "name", sep.date="_"), ".csv")
#> [1] "filename_2026-04-25.csv"

data(abmibirds)
x <- data.frame(Name=levels(abmibirds[["Common.Name"]]),
    NameAlnum=nameAlnum(levels(abmibirds[["Common.Name"]])),
    stringsAsFactors = TRUE)
x[grep("'", x$Name),]
#>                              Name                   NameAlnum
#> 14                Baird's Sparrow              Bairds Sparrow
#> 21             Barrow's Goldeneye           Barrows Goldeneye
#> 38               Bonaparte's Gull             Bonapartes Gull
#> 41             Brewer's Blackbird           Brewers Blackbird
#> 42               Brewer's Sparrow             Brewers Sparrow
#> 86                 Forster's Tern               Forsters Tern
#> 88                Franklin's Gull              Franklins Gull
#> 103          Hammond's Flycatcher         Hammonds Flycatcher
#> 112            Le Conte's Sparrow           Le Contes Sparrow
#> 117             Lincoln's Sparrow            Lincolns Sparrow
#> 123             Mccown's Longspur            Mccowns Longspur
#> 130 Nelson's Sharp-tailed Sparrow Nelsons Sharptailed Sparrow
#> 170                  Say's Phoebe                 Says Phoebe
#> 179               Sprague's Pipit              Spragues Pipit
#> 181             Swainson's Thrush            Swainsons Thrush
#> 206            Wilson's Phalarope           Wilsons Phalarope
#> 207              Wilson's Warbler             Wilsons Warbler

data.frame(out=sapply(c("asis", "first", "none", "all", "mixed"),
    function(z) nameAlnum("Olive-sided Flycatcher", z)),
    stringsAsFactors = TRUE)
#>                         out
#> asis  Olivesided Flycatcher
#> first Olivesided Flycatcher
#> none  olivesided flycatcher
#> all   OLIVESIDED FLYCATCHER
#> mixed Olivesided Flycatcher

z <- data.frame(Name=levels(abmibirds[["Common.Name"]]),
    NameNormalized=normalizeNames(levels(abmibirds[["Common.Name"]]),
        pattern=list("'", "-", " "), replacement=list("", "_", "_")),
    stringsAsFactors = TRUE)
z[grepl("'", z$Name) & grepl("-", z$Name),]
#>                              Name               NameNormalized
#> 130 Nelson's Sharp-tailed Sparrow Nelsons_Sharp_tailed_Sparrow
```
