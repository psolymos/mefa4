paste0date <-
function(..., collapse = NULL)
{
    paste0(paste0(..., collapse = collapse), Sys.Date())
}
