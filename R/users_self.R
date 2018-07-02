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

#' media/search
#'
#' Interacting with the media/search endpoint of Instagram's API
#'
#' @return Returns media data.
#' @examples
#' \dontrun{
#' ig_media <- ig_media_search()
#' as_tbl(ig_media)
#' }
#' @export
ig_media_search <- function(...) {
  ig_api_get(path = "media/search/", ...)
}


#' tags/{tag-name}/media/recent
#'
#' Interacting with the tags/{tag-name}/media/recent endpoint of Instagram's API
#'
#' @param tag Name of tag.
#' @return Returns tags media data.
#' @examples
#' \dontrun{
#' tags_media <- ig_tags_media_recent()
#' as_tbl(tags_media)
#' }
#' @export
ig_tags_media_recent <- function(tag = "nofilter", ...) {
  ig_api_get(path = sprintf("tags/%s/media/recent/", tag), ...)
}



#' tags/search
#'
#' Interacting with the tags/search endpoint of Instagram's API
#'
#' @return Returns tags data.
#' @examples
#' \dontrun{
#' ig_tags <- ig_tags_search()
#' as_tbl(ig_tags)
#' }
#' @export
ig_tags_search <- function(...) {
  ig_api_get(path = "tags/search/", ...)
}
