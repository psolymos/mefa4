# Multivariate Data Handling with S4 Classes and Sparse Matrices

An S4 update of the 'mefa' package using sparse matrices for enhanced
efficiency.

## Details

An S4 update of the 'mefa' package using sparse matrices for enhanced
efficiency. Sparse array-like objects are supported via lists of sparse
matrices.

Main functions: [`Xtab`](Xtab.md), [`Mefa`](Mefa.md).

Accessor and replacement functions: [`xtab`](samp.md),
[`samp`](samp.md), [`taxa`](samp.md).

Methods: [`mbind`](mbind.md), [`groupSums`](groupSums.md),
[`groupMeans`](groupSums.md).

Coercion methods and virtual classes defined for cross compatibility
with the [`mefa`](https://rdrr.io/pkg/mefa/man/mefa.html) package. S4
object classes are described in [`Mefa`](Mefa.md) help page.

The vignette `vignette("mefa4")` gives an overview of the package, gives
a comparison of S3 and S4 object classes, and presents a performance
review.

## Author

Peter Solymos

Maintainer: Peter Solymos \<solymos@ualberta.ca\>

## References

Solymos P. (2008) mefa: an R package for handling and reporting count
data. *Community Ecology* **9**, 125–127.

Solymos P. (2009) Processing ecological data in R with the mefa package.
*Journal of Statistical Software* **29(8)**, 1–28.
[doi:10.18637/jss.v029.i08](https://doi.org/10.18637/jss.v029.i08)

## See also

S3 classes: [`mefa`](https://rdrr.io/pkg/mefa/man/mefa.html)

## Examples

``` r
if (FALSE) { # \dontrun{
vignette("mefa4")
} # }
```
