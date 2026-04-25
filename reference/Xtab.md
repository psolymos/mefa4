# Sparse Cross Tabulation

Create a contingency table from cross-classifying factors, usually
contained in a data frame, using a formula interface.

## Usage

``` r
Xtab(formula = ~., data = parent.frame(), rdrop, cdrop,
subset, na.action, exclude = c(NA, NaN), drop.unused.levels = FALSE)
```

## Arguments

- formula:

  a [`formula`](https://rdrr.io/r/stats/formula.html) object with the
  cross-classifying variables (separated by +) on the right hand side
  (or an object which can be coerced to a formula). Interactions are not
  allowed. On the left hand side, one may optionally give a vector or a
  matrix of counts; in the latter case, the columns are interpreted as
  corresponding to the levels of a variable. This is useful if the data
  have already been tabulated, see the examples below.

- data:

  an optional matrix or data frame (or similar: see
  [`model.frame`](https://rdrr.io/r/stats/model.frame.html)) containing
  the variables in the formula formula. By default the variables are
  taken from environment(formula).

- rdrop, cdrop:

  logical (should zero marginal rows/columns be removed after cross
  tabulation), character or numeric (what rows/columns should be
  removed).

- subset:

  an optional vector specifying a subset of observations to be used.

- na.action:

  a function which indicates what should happen when the data contain
  NAs.

- exclude:

  a vector of values to be excluded when forming the set of levels of
  the classifying factors.

- drop.unused.levels:

  a logical indicating whether to drop unused levels in the classifying
  factors. If this is FALSE and there are unused levels, the table will
  contain zero marginals, and a subsequent chi-squared test for
  independence of the factors will not work.

## Details

The function creates two- or three-way cross tabulation. Only works for
two or three factors.

If a left hand side is given in formula, its entries are simply summed
over the cells corresponding to the right hand side; this also works if
the left hand side does not give counts.

## Value

A sparse numeric matrix inheriting from
[`sparseMatrix`](https://rdrr.io/pkg/Matrix/man/sparseMatrix.html),
specifically an object of S4 class `dgCMatrix`.

For three factors, a list of sparse matrices.

## Author

This function is a slight modification of the
[`xtabs`](https://rdrr.io/r/stats/xtabs.html) function in the stats
package.

Modified by Peter Solymos \<solymos@ualberta.ca\>

## See also

See also [`xtabs`](https://rdrr.io/r/stats/xtabs.html) in stats package.

[`sum_by`](groupSums.md) for sums over a classes ('one-way table'), and
[`Melt`](Melt.md) for the inverse operation of `Xtab`.

`"mefa"` S3 class: [`mefa`](https://rdrr.io/pkg/mefa/man/mefa.html) in
mefa package.

## Examples

``` r
x <- data.frame(
    sample = paste("Sample", c(1,1,2,2,3,4), sep="."),
    species = c(paste("Species", c(1,1,1,2,3), sep="."),  "zero.pseudo"),
    count = c(1,2,10,3,4,0),
    stringsAsFactors = TRUE)
x
#>     sample     species count
#> 1 Sample.1   Species.1     1
#> 2 Sample.1   Species.1     2
#> 3 Sample.2   Species.1    10
#> 4 Sample.2   Species.2     3
#> 5 Sample.3   Species.3     4
#> 6 Sample.4 zero.pseudo     0
## Xtab class, counts by repetitions in RHS
(x0 <- Xtab(~ sample + species, x))
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         2         .         .           .
#> Sample.2         1         1         .           .
#> Sample.3         .         .         1           .
#> Sample.4         .         .         .           1
## counts by LHS and repetitions in RHS
(x1 <- Xtab(count ~ sample + species, x))
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3         .         .         4           .
#> Sample.4         .         .         .           .
## drop all empty rows
(x2 <- Xtab(count ~ sample + species, x, cdrop=FALSE,rdrop=TRUE))
#> 3 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3         .         .         4           .
## drop all empty columns
Xtab(count ~ sample + species, x, cdrop=TRUE,rdrop=FALSE)
#> 4 x 3 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3
#> Sample.1         3         .         .
#> Sample.2        10         3         .
#> Sample.3         .         .         4
#> Sample.4         .         .         .
## drop specific columns by placeholder
Xtab(count ~ sample + species, x, cdrop="zero.pseudo")
#> 4 x 3 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3
#> Sample.1         3         .         .
#> Sample.2        10         3         .
#> Sample.3         .         .         4
#> Sample.4         .         .         .

## 2 and 3 way crosstabs
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
Xtab(count ~ sample + species, xx)
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3         .         .         4           .
#> Sample.4         .         .         .           .
Xtab(count ~ sample + species + segment, xx)
#> $f
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         1         .         .           .
#> Sample.2        10         .         .           .
#> Sample.3         .         .         4           .
#> Sample.4         .         .         .           .
#> 
#> $m
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         2         .         .           .
#> Sample.2         .         3         .           .
#> Sample.3         .         .         .           .
#> Sample.4         .         .         .           .
#> 
```
