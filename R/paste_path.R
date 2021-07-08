#' Paste a path in the current cursor position.
#' Paste a path in the current cursor position.
#' All backslashes are converted to slashes, and the path is quoted if necessary.
#'
#' @return nothing
#' @export
#' @importFrom rstudioapi insertText
#' @examples
#'
#' paste_path()
#'
paste_path <- function() {

   path_clip <- retrieve_path()

   if (is.null(path_clip)) {
      return(NULL)
   }

   rstudioapi::insertText(
      location = NULL,
      text = path_clip
   )

   NULL
}






#' Retrieve and escape a path from the clipboard
#'
#' @param wrap_quotes if TRUE, wrap in a character vector if not necessary
#' @return a character vector or NULL
#' @export
#' @importFrom clipr read_clip
#' @importFrom utils readClipboard
retrieve_path <- function(wrap_quotes = TRUE) {

   if(.Platform$OS.type != "windows") {
      x <- clipr::read_clip()
   } else {
      x <- utils::readClipboard()
   }

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
