#' Paste a path in the current cursor position.
#'
#' All backslashes are converted to slashes, and the path is quoted if necessary.
#'
#' @return nothing
#' @export
#' @importFrom rstudioapi insertText
#' @inheritParams retrieve_path
#' @rdname paste_path
#' @examples
#' \dontrun{
#'   paste_path()
#' }
paste_path <- function(wrap_quotes = TRUE) {

   path_clip <- retrieve_path(wrap_quotes = wrap_quotes)

   if (is.null(path_clip)) {
      return(NULL)
   }

   rstudioapi::insertText(
      location = NULL,
      text = path_clip
   )

   NULL
}

#' @describeIn paste_path Paste without wrapping in quotes
#' @inheritDotParams paste_path
paste_path_without_quotes <- function(...) {
   paste_path(wrap_quotes = FALSE)
}





#' Retrieve and escape a path from the clipboard
#'
#' #' All backslashes are converted to slashes, and the path is quoted if necessary.
#'
#' @param wrap_quotes if TRUE, wrap in double quotes (character vector) if necessary
#' @return a character vector or NULL
#' @export
#' @importFrom clipr read_clip
retrieve_path <- function(wrap_quotes = TRUE) {

   # if(.Platform$OS.type != "windows") {
   #    x <- clipr::read_clip()
   # } else {
   #    x <- utils::readClipboard()
   # }
   x <- clipr::read_clip()

   if (is.null(x)) {
      return(NULL)
   }

   x_norm <- gsub("\\\\", "/", x)

   if (wrap_quotes) {

      # Check that the input path is not quoted
      has_quotes <- length(grep('^([\'"]).+\\1$', x) > 0)

      if (!has_quotes) {
         x_norm <- paste0('"', x_norm, '"')
      }

   }

   x_norm
}
