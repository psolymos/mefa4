# Melting Matrices

The function reverses the side effects of cross tabulation.

## Usage

``` r
Melt(x)
```

## Arguments

- x:

  A matrix, or sparse matrix object, a list of sparse matrices with
  identical dimnames, a 'mefa' or 'Mefa' object.

## Value

A data frame with columns corresponding to `rows`, `cols`, possibly
`segm` (names of the list if `x` was a list of sparse matrices), and
`value`. `value` is numeric, other columns are factors.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

[`stack`](https://rdrr.io/r/utils/stack.html) in utils, and
[`melt`](https://rdrr.io/pkg/mefa/man/melt.mefa.html) in mefa package.

## Examples

``` r
xx <- data.frame(
    sample = paste("Sample", c(1,1,2,2,3,4), sep="."),
    species = c(paste("Species", c(1,1,1,2,3), sep="."),  "zero.pseudo"),
    count = c(1,2,10,3,4,0),
    segment = letters[c(6,13,6,13,6,6)],
    stringsAsFactors = TRUE)
xx
#>     sample     species count segment
#> 1 Sample.1   Species.1     1       f
#> 2 Sample.1   Species.1     2       m
#> 3 Sample.2   Species.1    10       f
#> 4 Sample.2   Species.2     3       m
#> 5 Sample.3   Species.3     4       f
#> 6 Sample.4 zero.pseudo     0       f
xx0 <- Xtab(count ~ sample + species, xx)
xx1 <- Xtab(count ~ sample + species + segment, xx)
(M1 <- Melt(xx0))
#>       rows      cols value
#> 1 Sample.1 Species.1     3
#> 2 Sample.2 Species.1    10
#> 3 Sample.2 Species.2     3
#> 4 Sample.3 Species.3     4
Melt(as.matrix(xx0))
#>       rows      cols value
#> 1 Sample.1 Species.1     3
#> 2 Sample.2 Species.1    10
#> 3 Sample.2 Species.2     3
#> 4 Sample.3 Species.3     4
(M2 <- Melt(xx1))
#>       rows      cols segm value
#> 1 Sample.1 Species.1    f     1
#> 2 Sample.2 Species.1    f    10
#> 3 Sample.3 Species.3    f     4
#> 4 Sample.1 Species.1    m     2
#> 5 Sample.2 Species.2    m     3
stopifnot(identical(Xtab(value ~ rows + cols, M1), xx0))
stopifnot(identical(Xtab(value ~ rows + cols + segm, M2), xx1))
```
