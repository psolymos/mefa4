# Compute Summary Statistics of Data Subsets

Compute summary statistics (sums, means) of data subsets.

## Usage

``` r
groupSums(object, ...)
# S4 method for class 'matrix'
groupSums(object, MARGIN, by, na.rm = FALSE, ...)
# S4 method for class 'sparseMatrix'
groupSums(object, MARGIN, by, na.rm = FALSE, ...)
# S4 method for class 'Mefa'
groupSums(object, MARGIN, by, replace, na.rm = FALSE, ...)

groupMeans(object, ...)
# S4 method for class 'matrix'
groupMeans(object, MARGIN, by, na.rm = FALSE, ...)
# S4 method for class 'sparseMatrix'
groupMeans(object, MARGIN, by, na.rm = FALSE, ...)
# S4 method for class 'Mefa'
groupMeans(object, MARGIN, by, replace, na.rm = FALSE, ...)

sum_by(x, by)
```

## Arguments

- object:

  an object.

- x:

  a vector.

- MARGIN:

  numeric, `1` indicates rows are to be summed/averaged, `2` indicates
  columns are to be summed/averaged. `c(1, 2)` is not yet implemented,
  but can be calculated calling the function twice.

- by:

  a vector of grouping elements corresponding to dimensions of `object`
  and `MARGIN`.

- replace:

  a data frame to be used when applying the method on a `"Mefa"` object.
  The attribute table corresponding to `MARGIN` is dropped (`NULL`),
  `replace`ment table can be specified via this argument.

- na.rm:

  logical. Should missing values be removed? Sum is calculated by
  zeroing out `NA` values, mean is calculated as dividing the sum by the
  number of non-`NA` values when collapsing.

- ...:

  other argument, currently not implemented.

## Details

The method sums/averages cells in a matrix. The functions behind these
methods use sparse matrices, so calculations can be more efficient
compared to using [`aggregate`](https://rdrr.io/r/stats/aggregate.html).

## Value

An object similar to the input one.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

[`rowSums`](https://rdrr.io/r/base/colSums.html),
[`rowMeans`](https://rdrr.io/r/base/colSums.html),
[`colSums`](https://rdrr.io/r/base/colSums.html),
[`colMeans`](https://rdrr.io/r/base/colSums.html)

Standard [`aggregate`](https://rdrr.io/r/stats/aggregate.html) in
package stats

[`aggregate.mefa`](https://rdrr.io/pkg/mefa/man/aggregate.mefa.html) in
package mefa for S3 `"mefa"` objects.

## Examples

``` r
x <- data.frame(
    sample = paste("Sample", c(1,1,2,2,3,4), sep="."),
    species = c(paste("Species", c(1,1,1,2,3), sep="."),
    "zero.pseudo"), count = c(1,2,10,3,4,0),
    stringsAsFactors = TRUE)
samp <- data.frame(samples=levels(x$sample), var1=1:2,
    stringsAsFactors = TRUE)
taxa <- data.frame(specnames=levels(x$species), var2=c("b","a"),
    stringsAsFactors = TRUE)
rownames(samp) <- samp$samples
rownames(taxa) <- taxa$specnames
x2 <- Xtab(count ~ sample + species, x, cdrop=FALSE,rdrop=TRUE)
x5 <- Mefa(x2, samp, taxa, join="inner")

groupSums(as.matrix(x2), 1, c(1,1,2))
#>   Species.1 Species.2 Species.3 zero.pseudo
#> 1        13         3         0           0
#> 2         0         0         4           0
groupSums(as.matrix(x2), 2, c(1,1,2,2))
#>           1 2
#> Sample.1  3 0
#> Sample.2 13 0
#> Sample.3  0 4
groupSums(x2, 1, c(1,1,2))
#> 2 x 4 sparse Matrix of class "dgCMatrix"
#>   Species.1 Species.2 Species.3 zero.pseudo
#> 1        13         3         .           .
#> 2         .         .         4           .
groupSums(x2, 2, c(1,1,2,2))
#> 3 x 2 sparse Matrix of class "dgCMatrix"
#>           1 2
#> Sample.1  3 .
#> Sample.2 13 .
#> Sample.3  . 4
groupSums(x5, 1, c(1,1,2))
#> Object of class "Mefa"
#>   ..@ xtab: 2 x 4 sparse Matrix
#>   ..@ samp: NULL
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: inner 
groupSums(x5, 2, c(1,1,2,2))
#> Object of class "Mefa"
#>   ..@ xtab: 3 x 2 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: NULL
#>   ..@ join: inner 

groupMeans(as.matrix(x2), 1, c(1,1,2))
#>   Species.1 Species.2 Species.3 zero.pseudo
#> 1       6.5       1.5         0           0
#> 2       0.0       0.0         4           0
groupMeans(as.matrix(x2), 2, c(1,1,2,2))
#>            1 2
#> Sample.1 1.5 0
#> Sample.2 6.5 0
#> Sample.3 0.0 2
groupMeans(x2, 1, c(1,1,2))
#> 2 x 4 sparse Matrix of class "dgCMatrix"
#>   Species.1 Species.2 Species.3 zero.pseudo
#> 1       6.5       1.5         .           .
#> 2       .         .           4           .
groupMeans(x2, 2, c(1,1,2,2))
#> 3 x 2 sparse Matrix of class "dgCMatrix"
#>            1 2
#> Sample.1 1.5 .
#> Sample.2 6.5 .
#> Sample.3 .   2
groupMeans(x5, 1, c(1,1,2))
#> Object of class "Mefa"
#>   ..@ xtab: 2 x 4 sparse Matrix
#>   ..@ samp: NULL
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: inner 
groupMeans(x5, 2, c(1,1,2,2))
#> Object of class "Mefa"
#>   ..@ xtab: 3 x 2 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: NULL
#>   ..@ join: inner 

sum_by(runif(100, 0, 1), sample(LETTERS[1:4], 100, replace=TRUE))
#>           x by
#> C 17.099100 29
#> A  7.992116 18
#> D 14.054393 29
#> B 12.379071 24
```
