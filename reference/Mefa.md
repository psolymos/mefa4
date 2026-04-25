# 'Mefa' Class

Creating an object of class `"Mefa"`.

## Usage

``` r
Mefa(xtab, samp, taxa, join = c("left", "inner"), drop = FALSE)
```

## Arguments

- xtab:

  a matrix or a sparse matrix.

- samp:

  a data frame or `NULL`.

- taxa:

  a data frame or `NULL`.

- join:

  character, `"left"` (default) or `"inner"`.

- drop:

  logical, if unused levels in the data frames should be dropped.

## Details

`samp` and `taxa` tables are matched with corresponding dimnames in
`xtab`: rownames with `samp`, colnames with `taxa`. If `join = "left"`,
all rows and columns in `xtab` are retained, while missing items in the
corresponding attribute tables are filled up with `NA`s. If
`join = "inner"`, only the intersection of corresponding names are
retained.

The `xtab` slot is a sparse matrix (`dgCMatrix`). The input should be in
class `MefaMatrix` that is a class union of `matrix` and `sparseMatrix`
classes.

The `samp` and `taxa` slots take data frame or `NULL`, which two form
the `MefaDataFrame` class union.

The virtual classes `mefa` and `stcs` are defined for seamless coercion
between S3 and S4 classes.

## Value

An S4 object of class `"Mefa"` with 4 slots: `xtab`, `samp`, `taxa`,
`join`.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## Note

If `xtab` has no dimnames, matching it up with the attribute tables can
be problematic.

## See also

Creating crosstabulations: [`Xtab`](Xtab.md),
[`xtabs`](https://rdrr.io/r/stats/xtabs.html) in package stats,
[`xtabs`](https://rdrr.io/r/stats/xtabs.html) in package stats

`"mefa"` S3 class: [`mefa`](https://rdrr.io/pkg/mefa/man/mefa.html) in
mefa package.

Accessing and replacing slots: [`xtab`](samp.md), [`samp`](samp.md),
[`taxa`](samp.md).

## Examples

``` r
x <- data.frame(
    sample = paste("Sample", c(1,1,2,2,3,4), sep="."),
    species = c(paste("Species", c(1,1,1,2,3), sep="."),  "zero.pseudo"),
    count = c(1,2,10,3,4,0),
    stringsAsFactors = TRUE)
samp <- data.frame(samples=levels(x$sample), var1=1:2,
    stringsAsFactors = TRUE)
taxa <- data.frame(specnames=levels(x$species), var2=c("b","a"),
    stringsAsFactors = TRUE)
rownames(samp) <- samp$samples
rownames(taxa) <- taxa$specnames

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

## Mefa class, standard
(x3 <- Mefa(x1, samp, taxa))
#> Object of class "Mefa"
#>   ..@ xtab: 4 x 4 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: left 
unclass(x3)
#> <S4 Type Object>
#> attr(,"xtab")
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3         .         .         4           .
#> Sample.4         .         .         .           .
#> attr(,"samp")
#>           samples var1
#> Sample.1 Sample.1    1
#> Sample.2 Sample.2    2
#> Sample.3 Sample.3    1
#> Sample.4 Sample.4    2
#> attr(,"taxa")
#>               specnames var2
#> Species.1     Species.1    b
#> Species.2     Species.2    a
#> Species.3     Species.3    b
#> zero.pseudo zero.pseudo    a
#> attr(,"join")
#> [1] "left"
x3@xtab
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3         .         .         4           .
#> Sample.4         .         .         .           .
x3@samp
#>           samples var1
#> Sample.1 Sample.1    1
#> Sample.2 Sample.2    2
#> Sample.3 Sample.3    1
#> Sample.4 Sample.4    2
x3@taxa
#>               specnames var2
#> Species.1     Species.1    b
#> Species.2     Species.2    a
#> Species.3     Species.3    b
#> zero.pseudo zero.pseudo    a
x3@join
#> [1] "left"

## effects of left join, NULL taxa slot, xtab is (not sparse) matrix
(x4 <- Mefa(as.matrix(x1), samp[1:2,]))
#> Object of class "Mefa"
#>   ..@ xtab: 4 x 4 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: NULL
#>   ..@ join: left 
unclass(x4)
#> <S4 Type Object>
#> attr(,"xtab")
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3         .         .         4           .
#> Sample.4         .         .         .           .
#> attr(,"samp")
#>           samples var1
#> Sample.1 Sample.1    1
#> Sample.2 Sample.2    2
#> Sample.3     <NA>   NA
#> Sample.4     <NA>   NA
#> attr(,"taxa")
#> `\001NULL\001`
#> attr(,"join")
#> [1] "left"

## effects of inner join (intersect)
(x5 <- Mefa(x2, samp, taxa, join="inner"))
#> Object of class "Mefa"
#>   ..@ xtab: 3 x 4 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: inner 
unclass(x5)
#> <S4 Type Object>
#> attr(,"xtab")
#> 3 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3         .         .         4           .
#> attr(,"samp")
#>           samples var1
#> Sample.1 Sample.1    1
#> Sample.2 Sample.2    2
#> Sample.3 Sample.3    1
#> attr(,"taxa")
#>               specnames var2
#> Species.1     Species.1    b
#> Species.2     Species.2    a
#> Species.3     Species.3    b
#> zero.pseudo zero.pseudo    a
#> attr(,"join")
#> [1] "inner"
unclass(Mefa(x1, samp[1:2,], join="inner"))
#> <S4 Type Object>
#> attr(,"xtab")
#> 2 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> attr(,"samp")
#>           samples var1
#> Sample.1 Sample.1    1
#> Sample.2 Sample.2    2
#> attr(,"taxa")
#> `\001NULL\001`
#> attr(,"join")
#> [1] "inner"

## xtab only Mefa
(x6 <- Mefa(x1))
#> Object of class "Mefa"
#>   ..@ xtab: 4 x 4 sparse Matrix
#>   ..@ samp: NULL
#>   ..@ taxa: NULL
#>   ..@ join: left 

## creating new Mefa object without Mefa()
new("Mefa", xtab=x1, samp=samp, taxa=taxa,join="left")
#> Object of class "Mefa"
#>   ..@ xtab: 4 x 4 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: left 

## dim and dimnames
dim(x5)
#> [1] 3 4
dimnames(x5)
#> [[1]]
#> [1] "Sample.1" "Sample.2" "Sample.3"
#> 
#> [[2]]
#> [1] "Species.1"   "Species.2"   "Species.3"   "zero.pseudo"
#> 
dn <- list(paste("S", 1:3, sep=""), paste("SPP", 1:4, sep=""))
dimnames(x5) <- dn
unclass(x5)
#> <S4 Type Object>
#> attr(,"xtab")
#> 3 x 4 sparse Matrix of class "dgCMatrix"
#>    SPP1 SPP2 SPP3 SPP4
#> S1    3    .    .    .
#> S2   10    3    .    .
#> S3    .    .    4    .
#> attr(,"samp")
#>     samples var1
#> S1 Sample.1    1
#> S2 Sample.2    2
#> S3 Sample.3    1
#> attr(,"taxa")
#>        specnames var2
#> SPP1   Species.1    b
#> SPP2   Species.2    a
#> SPP3   Species.3    b
#> SPP4 zero.pseudo    a
#> attr(,"join")
#> [1] "inner"
dimnames(x5)[[1]] <- paste("S", 1:3, sep="_")
unclass(x5)
#> <S4 Type Object>
#> attr(,"xtab")
#> 3 x 4 sparse Matrix of class "dgCMatrix"
#>     SPP1 SPP2 SPP3 SPP4
#> S_1    3    .    .    .
#> S_2   10    3    .    .
#> S_3    .    .    4    .
#> attr(,"samp")
#>      samples var1
#> S_1 Sample.1    1
#> S_2 Sample.2    2
#> S_3 Sample.3    1
#> attr(,"taxa")
#>        specnames var2
#> SPP1   Species.1    b
#> SPP2   Species.2    a
#> SPP3   Species.3    b
#> SPP4 zero.pseudo    a
#> attr(,"join")
#> [1] "inner"
dimnames(x5)[[2]] <- paste("SPP", 1:4, sep="_")
unclass(x5)
#> <S4 Type Object>
#> attr(,"xtab")
#> 3 x 4 sparse Matrix of class "dgCMatrix"
#>     SPP_1 SPP_2 SPP_3 SPP_4
#> S_1     3     .     .     .
#> S_2    10     3     .     .
#> S_3     .     .     4     .
#> attr(,"samp")
#>      samples var1
#> S_1 Sample.1    1
#> S_2 Sample.2    2
#> S_3 Sample.3    1
#> attr(,"taxa")
#>         specnames var2
#> SPP_1   Species.1    b
#> SPP_2   Species.2    a
#> SPP_3   Species.3    b
#> SPP_4 zero.pseudo    a
#> attr(,"join")
#> [1] "inner"

## transpose
x5
#> Object of class "Mefa"
#>   ..@ xtab: 3 x 4 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: inner 
t(x5)
#> Object of class "Mefa"
#>   ..@ xtab: 4 x 3 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: inner 
unclass(x5)
#> <S4 Type Object>
#> attr(,"xtab")
#> 3 x 4 sparse Matrix of class "dgCMatrix"
#>     SPP_1 SPP_2 SPP_3 SPP_4
#> S_1     3     .     .     .
#> S_2    10     3     .     .
#> S_3     .     .     4     .
#> attr(,"samp")
#>      samples var1
#> S_1 Sample.1    1
#> S_2 Sample.2    2
#> S_3 Sample.3    1
#> attr(,"taxa")
#>         specnames var2
#> SPP_1   Species.1    b
#> SPP_2   Species.2    a
#> SPP_3   Species.3    b
#> SPP_4 zero.pseudo    a
#> attr(,"join")
#> [1] "inner"
unclass(t(x5))
#> <S4 Type Object>
#> attr(,"xtab")
#> 4 x 3 sparse Matrix of class "dgCMatrix"
#>       S_1 S_2 S_3
#> SPP_1   3  10   .
#> SPP_2   .   3   .
#> SPP_3   .   .   4
#> SPP_4   .   .   .
#> attr(,"samp")
#>         specnames var2
#> SPP_1   Species.1    b
#> SPP_2   Species.2    a
#> SPP_3   Species.3    b
#> SPP_4 zero.pseudo    a
#> attr(,"taxa")
#>      samples var1
#> S_1 Sample.1    1
#> S_2 Sample.2    2
#> S_3 Sample.3    1
#> attr(,"join")
#> [1] "inner"

## 0 and 1 row/col Mefa object
x3[c(FALSE,FALSE,FALSE,FALSE),c(FALSE,FALSE,FALSE,FALSE)]
#> Object of class "Mefa"
#>   ..@ xtab: 0 x 0 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: left 
x3[c(TRUE,FALSE,FALSE,FALSE),c(FALSE,FALSE,FALSE,FALSE)]
#> Object of class "Mefa"
#>   ..@ xtab: 1 x 0 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: left 
x3[c(FALSE,FALSE,FALSE,FALSE),c(TRUE,FALSE,FALSE,FALSE)]
#> Object of class "Mefa"
#>   ..@ xtab: 0 x 1 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: left 
x3[c(TRUE,FALSE,FALSE,FALSE),c(TRUE,FALSE,FALSE,FALSE)]
#> Object of class "Mefa"
#>   ..@ xtab: 1 x 1 sparse Matrix
#>   ..@ samp: data frame with 2 variables
#>   ..@ taxa: data frame with 2 variables
#>   ..@ join: left 

## stack
stack(x3)
#>                samp        taxa values samp_samples samp_var1 taxa_specnames
#> Sample.1   Sample.1   Species.1      3     Sample.1         1      Species.1
#> Sample.2   Sample.2   Species.1     10     Sample.2         2      Species.1
#> Sample.3   Sample.3   Species.1      0     Sample.3         1      Species.1
#> Sample.4   Sample.4   Species.1      0     Sample.4         2      Species.1
#> Sample.1.1 Sample.1   Species.2      0     Sample.1         1      Species.2
#> Sample.2.1 Sample.2   Species.2      3     Sample.2         2      Species.2
#> Sample.3.1 Sample.3   Species.2      0     Sample.3         1      Species.2
#> Sample.4.1 Sample.4   Species.2      0     Sample.4         2      Species.2
#> Sample.1.2 Sample.1   Species.3      0     Sample.1         1      Species.3
#> Sample.2.2 Sample.2   Species.3      0     Sample.2         2      Species.3
#> Sample.3.2 Sample.3   Species.3      4     Sample.3         1      Species.3
#> Sample.4.2 Sample.4   Species.3      0     Sample.4         2      Species.3
#> Sample.1.3 Sample.1 zero.pseudo      0     Sample.1         1    zero.pseudo
#> Sample.2.3 Sample.2 zero.pseudo      0     Sample.2         2    zero.pseudo
#> Sample.3.3 Sample.3 zero.pseudo      0     Sample.3         1    zero.pseudo
#> Sample.4.3 Sample.4 zero.pseudo      0     Sample.4         2    zero.pseudo
#>            taxa_var2
#> Sample.1           b
#> Sample.2           b
#> Sample.3           b
#> Sample.4           b
#> Sample.1.1         a
#> Sample.2.1         a
#> Sample.3.1         a
#> Sample.4.1         a
#> Sample.1.2         b
#> Sample.2.2         b
#> Sample.3.2         b
#> Sample.4.2         b
#> Sample.1.3         a
#> Sample.2.3         a
#> Sample.3.3         a
#> Sample.4.3         a
```
