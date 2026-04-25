# Non Duplicated Rows in Data Frame

Subset a data frame using non duplicated elements in a vector.

## Usage

``` r
nonDuplicated(x, y, change.rownames = FALSE, na.rm = FALSE)
```

## Arguments

- x:

  a data frame.

- y:

  a vector. It can be a name of a column in `x` without quotes.

- change.rownames:

  if original rownames of `x` are to be replaced by unique non
  duplicated values of `y`.

- na.rm:

  logical. If rows should be removed where `y` is `NA`. This is to be
  applied if values of `y` are used as rownames by setting
  `change.rownames = TRUE`

## Details

This function is handy to keep only one set of duplicated data that is
common in long formatted database files.

## Value

A data frame.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

[`duplicated`](https://rdrr.io/r/base/duplicated.html)

## Examples

``` r
data(abmibirds)
x <- nonDuplicated(abmibirds, abmibirds$ABMI.Site, TRUE)
## or equivalently
#x <- nonDuplicated(abmibirds, ABMI.Site, TRUE)
dim(abmibirds)
#> [1] 59341    21
dim(x)
#> [1] 330  21
length(unique(abmibirds$ABMI.Site))
#> [1] 330
```
