#' users/self
#'
#' Interacting with the users/self endpoint of Instagram's API
#'
#' @return Returns user data.
#' @examples
#' \dontrun{
#' my_ig <- ig_users_self()
#' as_tbl(my_ig)
#' }
#' @export
ig_users_self <- function() {
  ig_api_get(path = "users/self/")
}

#' users/self/media/recent
#'
#' Interacting with the users/self/media/recent endpoint of Instagram's API
#'
#' @return Returns user media data.
#' @examples
#' \dontrun{
#' my_media <- ig_users_self_media_recent()
#' as_tbl(my_media)
#' }
#' @export
ig_users_self_media_recent <- function() {
  ig_api_get(path = "users/self/media/recent/")
}
