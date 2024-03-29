# mefa4: multivariate data handling with S4 classes and sparse matrices

[![CRAN version](https://www.r-pkg.org/badges/version/mefa4)](https://CRAN.R-project.org/package=mefa4)
[![CRAN RStudio mirror downloads](https://cranlogs.r-pkg.org/badges/grand-total/mefa4)](https://CRAN.R-project.org/package=mefa4)
[![check](https://github.com/psolymos/mefa4/actions/workflows/check.yml/badge.svg)](https://github.com/psolymos/mefa4/actions/workflows/check.yml)

An S4 update of the mefa package using sparse matrices for enhanced efficiency.
Sparse array-like objects are supported via lists of sparse matrices.

* Main functions: `Xtab`, `Mefa`.
* Accessor and replacement functions: `xtab`, `samp`, `taxa`.
* Methods: `mbind`, `groupSums`, `groupMeans`.

See tutorial with design decisions and performance comparisons ([Rmd](https://github.com/psolymos/mefa4/blob/master/extras/mefa4.Rmd), [PDF](https://github.com/psolymos/mefa4/raw/master/extras/mefa4.pdf))

## Versions

Install CRAN version as:

```R
install.packages("mefa4")
```

Install development version from GitHub:

```R
library(devtools)
install_github("psolymos/mefa4")
```

User visible changes are listed in the [NEWS](https://github.com/psolymos/mefa4/blob/master/NEWS.md) file.

Previously hosted at [R-Forge](https://r-forge.r-project.org/projects/mefa/) (until rev 619).

## Report a problem

Use the [issue tracker](https://github.com/psolymos/mefa4/issues)
to report a problem.

## License

[GPL-2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

## References

Solymos P. 2008. mefa: an R package for handling and reporting count data.
_Community Ecology_ **9**, 125-127. ([PDF](https://drive.google.com/file/d/0B-q59n6LIwYPdWVkWlQ1ZzFMS3c/view?usp=sharing))

Solymos P. 2009. Processing ecological data in R with the mefa package.
_Journal of Statistical Software_ **29(8)**, 1-28.
DOI: [10.18637/jss.v029.i08](https://doi.org/10.18637/jss.v029.i08)
