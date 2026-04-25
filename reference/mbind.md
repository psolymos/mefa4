# Combine R Objects by Rows and Columns

Combine R objects by rows and columns.

## Usage

``` r
mbind(x, y, fill, ...)
mbind2(x, y, fill, ...)
```

## Arguments

- x, y:

  objects to combine, see Details.

- fill:

  numeric value or `NA` (default) to fill up outer set (not part of
  union) of dimnames.

- ...:

  other argument, not used.

## Details

`x` and `y` are combined in a left join manner, meaning that all the
elements in `x` are retained, and only non-overlapping elements in `y`
are used. Elements of the returning object that are not part of `x` and
`y` (outer set) are filled up with `fill`.

If relational table in `x` is `NULL`, corresponding values from same
table of `y` are used.

`mbind2` combines `x` and `y` so that inner set is calculated as sum of
corresponding elements from `x` and `y` (unlike in `mbind` with a left
join manner).

## Value

An object similar to the input one.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

[`rbind`](https://rdrr.io/r/base/cbind.html),
[`cbind`](https://rdrr.io/r/base/cbind.html)

## Examples

``` r
x=matrix(1:4,2,2)
rownames(x) <- c("a","b")
colnames(x) <- c("A","B")
y=matrix(11:14,2,2)
rownames(y) <- c("b","c")
colnames(y) <- c("B","C")

sampx <- data.frame(x1=1:2, x2=2:1,
    stringsAsFactors = TRUE)
rownames(sampx) <- rownames(x)
sampy <- data.frame(x1=3:4, x3=10:11,
    stringsAsFactors = TRUE)
rownames(sampy) <- rownames(y)
taxay <- data.frame(x1=1:2, x2=2:1,
    stringsAsFactors = TRUE)
rownames(taxay) <- colnames(y)
taxax <- NULL

mbind(x,y)
#>    A  B  C
#> a  1  3 NA
#> b  2  4 13
#> c NA 12 14
mbind(as(x,"sparseMatrix"),as(y,"sparseMatrix"))
#> 3 x 3 sparse Matrix of class "dgCMatrix"
#>    A  B  C
#> a  1  3 NA
#> b  2  4 13
#> c NA 12 14
xy <- mbind(Mefa(x,sampx),Mefa(y,sampy,taxay))
unclass(xy)
#> <S4 Type Object>
#> attr(,"xtab")
#> 3 x 3 sparse Matrix of class "dgCMatrix"
#>    A  B  C
#> a  1  3 NA
#> b  2  4 13
#> c NA 12 14
#> attr(,"samp")
#>   x1 x2 x3
#> a  1  2 NA
#> b  2  1 10
#> c  4 NA 11
#> attr(,"taxa")
#>   x1 x2
#> A NA NA
#> B  1  2
#> C  2  1
#> attr(,"join")
#> [1] "left"

mbind2(x,y)
#>    A  B  C
#> a  1  3 NA
#> b  2 15 13
#> c NA 12 14
mbind2(as(x,"sparseMatrix"),as(y,"sparseMatrix"))
#> 3 x 3 sparse Matrix of class "dgCMatrix"
#>    A  B  C
#> a  1  3 NA
#> b  2 15 13
#> c NA 12 14
xtab(xy) <- mbind2(x, y)
unclass(xy)
#> <S4 Type Object>
#> attr(,"xtab")
#> 3 x 3 sparse Matrix of class "dgCMatrix"
#>    A  B  C
#> a  1  3 NA
#> b  2 15 13
#> c NA 12 14
#> attr(,"samp")
#>   x1 x2 x3
#> a  1  2 NA
#> b  2  1 10
#> c  4 NA 11
#> attr(,"taxa")
#>   x1 x2
#> A NA NA
#> B  1  2
#> C  2  1
#> attr(,"join")
#> [1] "left"
```
