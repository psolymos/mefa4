# Utility functions for factors and compositional data

Utility functions for factors and compositional data.

## Usage

``` r
compare_sets(x, y)
find_max(x)
find_min(x)
reclass(x, map, all = FALSE, allow_NA = FALSE)
redistribute(x, source, target = NULL)
```

## Arguments

- x, y:

  any type for `compare_sets`, matrix for `find_max`, `find_min`, and
  `redistribute`, a factor for `reclass`.

- map:

  a reclassification matrix with 2 columns (1st: original levels, 2nd:
  output levels mapped to original levels).

- all:

  logical, whether all levels from mapping matrix should be applied on
  the return object.

- allow_NA:

  logical, whether `NA`s are allowed as part of `map`.

- source:

  numeric or character, single column index for input matrix `x`.

- target:

  numeric or character, column index or indices for input matrix `x`.

## Value

A matrix `compare_sets`.

A data frame for `find_max` and `find_min`.

A reclassified factor for `reclass`.

A matrix for `redistribute` where the source column values are
redistributed among the target columns proportionally.

## Author

Peter Solymos \<solymos@ualberta.ca\>

## See also

[`intersect`](https://rdrr.io/r/base/sets.html),
[`setdiff`](https://rdrr.io/r/base/sets.html),
[`union`](https://rdrr.io/r/base/sets.html),
[`relevel`](https://rdrr.io/r/stats/relevel.html),
[`reorder`](https://rdrr.io/r/stats/reorder.factor.html)

## Examples

``` r
## numeric vector
compare_sets(1:10, 8:15)
#>        xlength ylength intersect union xbutnoty ybutnotx
#> labels      10       8         3    15        7        5
#> unique      10       8         3    15        7        5
## factor with 'zombie' labels
compare_sets(factor(1:10, levels=1:10), factor(8:15, levels=1:15))
#>        xlength ylength intersect union xbutnoty ybutnotx
#> labels      10      15        10    15        0        5
#> unique      10       8         3    15        7        5

(mat <- matrix(rnorm(10*5), 10, 5))
#>               [,1]        [,2]        [,3]       [,4]        [,5]
#>  [1,] -1.400043517 -0.55369938  0.46815442  0.9353632  0.07003485
#>  [2,]  0.255317055  0.62898204  0.36295126  0.1764886 -0.63912332
#>  [3,] -2.437263611  2.06502490 -1.30454355  0.2436855 -0.04996490
#>  [4,] -0.005571287 -1.63098940  0.73777632  1.6235489 -0.25148344
#>  [5,]  0.621552721  0.51242695  1.88850493  0.1120381  0.44479712
#>  [6,]  1.148411606 -1.86301149 -0.09744510 -0.1339970  2.75541758
#>  [7,] -1.821817661 -0.52201251 -0.93584735 -1.9100875  0.04653138
#>  [8,] -0.247325302 -0.05260191 -0.01595031 -0.2792372  0.57770907
#>  [9,] -0.244199607  0.54299634 -0.82678895 -0.3134460  0.11819487
#> [10,] -0.282705449 -0.91407483 -1.51239965  1.0673079 -1.91172049
(m <- find_max(mat))
#>    index      value
#> 1     X4 0.93536319
#> 2     X2 0.62898204
#> 3     X2 2.06502490
#> 4     X4 1.62354888
#> 5     X3 1.88850493
#> 6     X5 2.75541758
#> 7     X5 0.04653138
#> 8     X5 0.57770907
#> 9     X2 0.54299634
#> 10    X4 1.06730788
## column indices
as.integer(m$index)
#>  [1] 4 2 2 4 3 5 5 5 2 4
find_min(mat)
#>    index      value
#> 1     X1 -1.4000435
#> 2     X5 -0.6391233
#> 3     X1 -2.4372636
#> 4     X2 -1.6309894
#> 5     X4  0.1120381
#> 6     X2 -1.8630115
#> 7     X4 -1.9100875
#> 8     X4 -0.2792372
#> 9     X3 -0.8267890
#> 10    X5 -1.9117205

map <- cbind(c("a","b","c","d","e","f","g"),
             c("A","B","B","C","D","D","E"))
#x <- factor(sample(map[1:6,1], 100, replace=TRUE), levels=map[,1])
x <- as.factor(sample(map[1:6,1], 100, replace=TRUE))
x[2] <- NA
table(x, reclass(x, map, all = FALSE), useNA="always")
#>       
#> x       A  B  C  D <NA>
#>   a    20  0  0  0    0
#>   b     0 17  0  0    0
#>   c     0 16  0  0    0
#>   d     0  0 18  0    0
#>   e     0  0  0 18    0
#>   f     0  0  0 10    0
#>   <NA>  0  0  0  0    1
table(x, reclass(x, map, all = TRUE), useNA="always")
#>       
#> x       A  B  C  D  E <NA>
#>   a    20  0  0  0  0    0
#>   b     0 17  0  0  0    0
#>   c     0 16  0  0  0    0
#>   d     0  0 18  0  0    0
#>   e     0  0  0 18  0    0
#>   f     0  0  0 10  0    0
#>   <NA>  0  0  0  0  0    1

map[c(4, 7), 2] <- NA
table(x, reclass(x, map, all = FALSE, allow_NA = TRUE), useNA="always")
#>       
#> x       A  B  D <NA>
#>   a    20  0  0    0
#>   b     0 17  0    0
#>   c     0 16  0    0
#>   d     0  0  0   18
#>   e     0  0 18    0
#>   f     0  0 10    0
#>   <NA>  0  0  0    1
table(x, reclass(x, map, all = TRUE, allow_NA = TRUE), useNA="always")
#>       
#> x       A  B  D <NA>
#>   a    20  0  0    0
#>   b     0 17  0    0
#>   c     0 16  0    0
#>   d     0  0  0   18
#>   e     0  0 18    0
#>   f     0  0 10    0
#>   <NA>  0  0  0    1

(mat2 <- exp(mat) / rowSums(exp(mat)))
#>              [,1]        [,2]       [,3]       [,4]       [,5]
#>  [1,] 0.040831390 0.095182422 0.26444918 0.42193778 0.17759923
#>  [2,] 0.204093071 0.296557494 0.22728627 0.18862250 0.08344066
#>  [3,] 0.008346517 0.753050903 0.02590833 0.12185032 0.09084393
#>  [4,] 0.108918579 0.021438374 0.22905181 0.55541789 0.08517334
#>  [5,] 0.145234726 0.130220017 0.51558565 0.08725515 0.12170446
#>  [6,] 0.151466054 0.007455399 0.04357593 0.04201190 0.75549072
#>  [7,] 0.069027282 0.253232229 0.16741439 0.06319543 0.44713066
#>  [8,] 0.148679922 0.180642369 0.18738603 0.14401016 0.33928152
#>  [9,] 0.163250927 0.358699287 0.09116756 0.15232891 0.23455332
#> [10,] 0.170130393 0.090486058 0.04974306 0.65627407 0.03336642
(rmat2 <- redistribute(mat2, source = 1, target = 2:4))
#>       [,1]       [,2]       [,3]      [,4]       [,5]
#>  [1,]    0 0.10015502 0.27826475 0.4439810 0.17759923
#>  [2,]    0 0.38150935 0.29239469 0.2426553 0.08344066
#>  [3,]    0 0.76002835 0.02614838 0.1229793 0.09084393
#>  [4,]    0 0.02433577 0.26000819 0.6304827 0.08517334
#>  [5,]    0 0.15601933 0.61773398 0.1045422 0.12170446
#>  [6,]    0 0.01959212 0.11451364 0.1104035 0.75549072
#>  [7,]    0 0.28935958 0.19129855 0.0722112 0.44713066
#>  [8,]    0 0.23309524 0.24179705 0.1858262 0.33928152
#>  [9,]    0 0.45594008 0.11588242 0.1936242 0.23455332
#> [10,]    0 0.10981357 0.06036801 0.7964520 0.03336642
colMeans(mat2)
#> [1] 0.1209979 0.2186965 0.1801568 0.2432904 0.2368584
colMeans(rmat2)
#> [1] 0.0000000 0.2529848 0.2198410 0.2903158 0.2368584
stopifnot(abs(sum(mat2) - sum(rmat2)) < 10^-6)
```
