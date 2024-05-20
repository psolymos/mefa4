# Version 0.3-10 -- May 19, 2024

* Maintainer email changed to personal email.

# Version 0.3-9 -- Sep 8, 2022

* Addressing Matrix 1.5-0 deprecation issue.

# Version 0.3-8 -- Oct 6, 2021

* Use DOI to JSS article instead of URL.
# Version 0.3-7 -- Feb 28, 2020

* `stringsAsFactors = TRUE` added to `data.frame()` calls
  to prepare for R-devel changes.

# Version 0.3-6 -- Jul 20, 2019

* `find_max` and `find_min` are much now faster.

# Version 0.3-5 -- Mar 24, 2018

* `sum_by` to sum a vector by grouping indices.
* `Melt` uses `unique` colnames to avoid duplicate factor levels warning.
* `rBind` and `cBind` deprecated and `rbind`/`cbind` is used
  (https://stat.ethz.ch/pipermail/r-devel/2018-March/075737.html),
  package now depends on R (>= 3.2.0).

# Version 0.3-4 -- Oct 12, 2016

* New functions: `'%notin%'`, the negation of `'%in%'`;
  `reclass` for reclassifying factors;
  `redistribute` for redistributing values in a matrix.
* `inst/CITATION` file updated.

# Version 0.3-3 -- Feb 29, 2016

* `nonDuplicated` now uses `drop=FALSE` to prevent 1-column
  inputs to loose their dimensions.
* New function: `compare_sets` to compare sets.
* New function: `find_max` and `find_min` to find max/min index and
  value for rows of a matrix.
* pbapply is now a dependency.

# Version 0.3-2 -- Nov 21, 2015

* New function: `r2rmd` to parse an ordinary R source file
  and return an Rmd file by trimming double hashes and wrapping
  code chunks.
* Vignette removed from package, migrated to development
  site on GitHub.

# Version 0.3-1 -- Nov 7, 2013

* stack method for Mefa objects:
  column labels for `@taxa` tables fixed.
* New functions: `pasteDate`, `paste0date`, `nameAlnum`.
  These were added to facilitate common character operations
  (versioning files, cleaning up taxonomic names).

# Version 0.3-0 -- Sept 25, 2013

* Spell check completed using `utils:::aspell`.
* Import methods pkg in namespace to satisfy R 3.0.2 checks.
* Depends: R (>= 2.14.0) because vignette directory has moved.

# Version 0.2-9 -- July 11, 2013

* `Xtab`: 1-row/col matrices dropped dimnames -- now fixed.
* Vignette moved to vignettes from `inst/doc`.

# Version 0.2-8 -- July 6, 2012

* `mbind2`: inner set is based on x+y instead of left join x.
  Methods for matrix and sparse matrix classes, but not for
  Mefa where the sum is not trivial.
* `nonDuplicated` gained `na.rm` argument to handle
  possible duplicates in row names.

# Version 0.2-7 -- May 2, 2012

* `inst/COPYING` removed.
* `stack` method added to Mefa class.
* `groupSums`, `groupMeans`: failed when join was `"inner"` and both
  `@samp` and `@taxa` slots of the new object were `NULL`. Check
  on `NULL` attribute table related join type is now relaxed
  for object class Mefa (reported by D. Stralberg).
* `mbind` uses `drop=TRUE` to protect single column/row cases.

# Version 0.2-6 -- March 19, 2012

* Rd link to `Matrix:::xtabs` removed (`sparse=TRUE` is in
  `stats:::xtabs`). Reported by Uwe Ligges.

# Version 0.2-5 -- October 18, 2011

* Startup message: line break removed.

# Version 0.2-4 -- August 23, 2011

* `groupMeans`: `NA` handling changed, mean is calculated
  as dividing by the non-`NA` values when collapsing.

# Version 0.2-3 -- July 9, 2011

* `packageStartupMessage` used in `zzz.R` `.onAttach`.
* Typos fixed in vignette and help pages.
* 1x1 dim issues fixed again using `drop=FALSE`
  at many places (`Mefa`, `<-`, `[`, `mbind`).
* typo corrected in `mbind` for Mefa objects that
  left `TAXAPART` temp variable in result.
* `@samp`/`@taxa` table handling in `mbind` for Mefa objects
  is revised, not using default `merge(..., all=TRUE)`.
* `Xtab`: lhs must be numeric.

# Version 0.2-2 -- May 13, 2011

* Allowing for 0 and 1 row/col Mefa objects (`'xtab<-'` and `'['`).
* `nonDuplicated` finds y in data frame and patent frame first.

# Version 0.2-1 -- February 14, 2011

* `Melt` function added to reverse side effects of `Xtab`.
* Docs for `Melt` added (Rd, tests, vignette).

# Version 0.2-0 -- February 7, 2011

* First public CRAN release.

# Version 0.1-2 -- January 26, 2011

* `nonDuplicated` function added.
* segmented `Xtab` output implemented
  as list of sparse matrices.

# Version 0.1-1 -- January 25, 2011

* S4 classes working properly.
* `/tests` dir added to pkg tree.
* Xtab class is redundant,
  use dgCMatrix class instead.
* A vignette with design decisions
  added, it also has the performance
  comparison.
* `mbind` method for binding matrices
  added with a 'left join' implementation.
* Rd files added, needs proofreading.

# Version 0.1-0 -- January 20, 2011

* Start development for S4 classes.
