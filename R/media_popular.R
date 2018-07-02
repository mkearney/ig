#' media/popular
#'
#' Interacting with the media/popular endpoint of Instagram's API
#'
#' @return Returns user data.
#' @examples
#' \dontrun{
#' pop <- ig_media_popular()
#' as_tbl(pop)
#' }
#' @export
ig_media_popular <- function() {
  ig_api_get(path = "media/popular/")
}

