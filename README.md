mefa4: multivariate data handling with S4 classes and sparse matrices
====

This is the imported version of the mefa4 R package from the [mefa project on R-Forge](https://r-forge.r-project.org/projects/mefa/) (rev 619).

An S4 update of the mefa package using sparse matrices for enhanced efficiency.
Sparse array-like objects are supported via lists of sparse matrices.

* Main functions: `Xtab`, `Mefa`.
* Accessor and replacement functions: `xtab`, `samp`, `taxa`.
* Methods: `mbind`, `groupSums`, `groupMeans`.

Coercion methods and virtual classes defined for
cross compatibility with the [mefa](http://cran.r-project.org/package=mefa) package. S4 object classes are described in `Mefa` help page.

The vignette `vignette("mefa4")` gives an overview of the package,
gives a comparison of S3 and S4 object classes, and presents a performance
review.

Stable version at CRAN: http://cran.r-project.org/package=mefa4

References
----------

Solymos P. 2008. mefa: an R package for handling and reporting count data. _Community Ecology_ **9**, 125-127.

Solymos P. 2009. Processing ecological data in R with the mefa package. _Journal of Statistical Software_ **29(8)**, 1-28. 
http://www.jstatsoft.org/v29/i08/


