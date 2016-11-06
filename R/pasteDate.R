## atatch a time stamp to file names etc.
pasteDate <-
function(..., sep = " ", collapse = NULL, sep.date = sep)
{
    out <- paste(..., sep = sep, collapse = collapse)
    paste(out, Sys.Date(), sep = sep.date)
}
