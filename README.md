# mefa4: multivariate data handling with S4 classes and sparse matrices

[![CRAN version](http://www.r-pkg.org/badges/version/mefa4)](http://cran.rstudio.com/web/packages/mefa4/index.html)
[![CRAN RStudio mirror downloads](http://cranlogs.r-pkg.org/badges/grand-total/mefa4)](http://cran.rstudio.com/web/packages/mefa4/index.html)
[![Linux build Status](https://travis-ci.org/psolymos/mefa4.svg?branch=master)](https://travis-ci.org/psolymos/mefa4)
[![Windows build status](https://ci.appveyor.com/api/projects/status/1tc542dlqitdfkbo?svg=true)](https://ci.appveyor.com/project/psolymos/mefa4)
[![Code coverage status](https://codecov.io/gh/psolymos/mefa4/branch/master/graph/badge.svg)](https://codecov.io/gh/psolymos/mefa4)

This is the imported version of the mefa4 R package from the [mefa project on R-Forge](https://r-forge.r-project.org/projects/mefa/) (rev 619).

An S4 update of the mefa package using sparse matrices for enhanced efficiency.
Sparse array-like objects are supported via lists of sparse matrices.

* Main functions: `Xtab`, `Mefa`.
* Accessor and replacement functions: `xtab`, `samp`, `taxa`.
* Methods: `mbind`, `groupSums`, `groupMeans`.

## Versions

Install CRAN version as:

```
install.packages("mefa4")
```

Install development version from GitHub:

```
library(devtools)
install_github("psolymos/mefa4")
```

User visible changes are listed in the [NEWS](https://github.com/psolymos/mefa4/blob/master/NEWS.md) file.

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
URL: [http://www.jstatsoft.org/v29/i08/](http://www.jstatsoft.org/v29/i08/)
