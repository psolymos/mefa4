# Accessing and Replacing Parts of 'Mefa' Objects

Methods to access and replace parts (elements, slots) of `"Mefa"`
objects.

## Usage

``` r
xtab(x)
`xtab<-`(x, value)

samp(x)
`samp<-`(x, value)

taxa(x)
`taxa<-`(x, value)
```

## Arguments

- x:

  an object of S4 class `"Mefa"`.

- value:

  replacement value.

## Details

The `[` method ensures that the `xtab` sparse matrix part and the
corresponding attribute tables are subsetted correctly.

Validity check is performed when replacing slots of an object.

## Value

An object of S4 class `"Mefa"`.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

[`Mefa`](Mefa.md)

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
x1 <- Xtab(count ~ sample + species, x)
x3 <- Mefa(x1, samp, taxa)

## accessing the xtab slot
xtab(x3)
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3         .         .         4           .
#> Sample.4         .         .         .           .
## replacing the slot value
x1[3,1] <- 999
xtab(x3) <- x1
xtab(x3)
#> 4 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.1         3         .         .           .
#> Sample.2        10         3         .           .
#> Sample.3       999         .         4           .
#> Sample.4         .         .         .           .

## accessing and replacing the samp slot
samp(x3)
#>           samples var1
#> Sample.1 Sample.1    1
#> Sample.2 Sample.2    2
#> Sample.3 Sample.3    1
#> Sample.4 Sample.4    2
samp(x3) <- NULL
samp(x3)
#> NULL
samp(x3) <- samp[1:3,]
samp(x3)
#>           samples var1
#> Sample.1 Sample.1    1
#> Sample.2 Sample.2    2
#> Sample.3 Sample.3    1
#> Sample.4     <NA>   NA

## accessing and replacing the taxa slot
taxa(x3)
#>               specnames var2
#> Species.1     Species.1    b
#> Species.2     Species.2    a
#> Species.3     Species.3    b
#> zero.pseudo zero.pseudo    a
taxa(x3) <- NULL
taxa(x3)
#> NULL
taxa(x3) <- taxa[1:3,]
taxa(x3)
#>             specnames var2
#> Species.1   Species.1    b
#> Species.2   Species.2    a
#> Species.3   Species.3    b
#> zero.pseudo      <NA> <NA>

## subsetting
unclass(x3[3:2, 1:2])
#> <S4 Type Object>
#> attr(,"xtab")
#> 2 x 2 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2
#> Sample.3       999         .
#> Sample.2        10         3
#> attr(,"samp")
#>           samples var1
#> Sample.3 Sample.3    1
#> Sample.2 Sample.2    2
#> attr(,"taxa")
#>           specnames var2
#> Species.1 Species.1    b
#> Species.2 Species.2    a
#> attr(,"join")
#> [1] "left"
unclass(x3[3:2,])
#> <S4 Type Object>
#> attr(,"xtab")
#> 2 x 4 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2 Species.3 zero.pseudo
#> Sample.3       999         .         4           .
#> Sample.2        10         3         .           .
#> attr(,"samp")
#>           samples var1
#> Sample.3 Sample.3    1
#> Sample.2 Sample.2    2
#> attr(,"taxa")
#>             specnames var2
#> Species.1   Species.1    b
#> Species.2   Species.2    a
#> Species.3   Species.3    b
#> zero.pseudo      <NA> <NA>
#> attr(,"join")
#> [1] "left"
unclass(x3[,1:2])
#> <S4 Type Object>
#> attr(,"xtab")
#> 4 x 2 sparse Matrix of class "dgCMatrix"
#>          Species.1 Species.2
#> Sample.1         3         .
#> Sample.2        10         3
#> Sample.3       999         .
#> Sample.4         .         .
#> attr(,"samp")
#>           samples var1
#> Sample.1 Sample.1    1
#> Sample.2 Sample.2    2
#> Sample.3 Sample.3    1
#> Sample.4     <NA>   NA
#> attr(,"taxa")
#>           specnames var2
#> Species.1 Species.1    b
#> Species.2 Species.2    a
#> attr(,"join")
#> [1] "left"
```
