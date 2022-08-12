## class definitions

## class unions
setClassUnion("MefaMatrix", c("matrix","dgCMatrix"))
setClassUnion("MefaDataFrame", c("data.frame","NULL"))

## virtual classes to old mefa classes
setClass("stcs", representation("VIRTUAL"))
setClass("mefa", representation("VIRTUAL"))

## main Mefa class
setClass("Mefa",
    representation(
        xtab = "MefaMatrix",
        samp = "MefaDataFrame",
        taxa = "MefaDataFrame",
        join = "character"),
    prototype = list(
        # xtab = as(matrix(0,0,0), "dgCMatrix"),
        xtab = as(as(as(matrix(0,0,0), "dMatrix"), "generalMatrix"), "CsparseMatrix"),
        samp = NULL,
        taxa = NULL,
        join = "left"),
    validity = function(object) {
        if (is.null(dim(object@xtab)))
            return("'xtab' must have a 'dim' attribute")
        if (length(dim(object@xtab)) != 2)
            return("'xtab' dimension must be 2")
        if (!is.null(object@samp) &&
            !identical(rownames(object@xtab), rownames(object@samp)))
            return("Inconsistent 'xtab' and 'samp' dimnames")
        if (!is.null(object@taxa) &&
            !identical(colnames(object@xtab), rownames(object@taxa)))
            return("Inconsistent 'xtab' and 'taxa' dimnames")
        if (!(object@join %in% c("left", "inner")))
            return("'join' must be in c(\"left\", \"inner\")")
#        if (is.null(object@samp) &&
#            is.null(object@taxa) &&
#            object@join != "left")
#            return("'join' must be \"left\" if both 'samp' and 'taxa' slots are 'NULL'")
        TRUE
    })
