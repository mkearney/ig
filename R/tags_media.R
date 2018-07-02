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


#' media/search
#'
#' Interacting with the media/search endpoint of Instagram's API
#'
#' @param ... Passed to query string.
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
#' @param ... Passed to query string.
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


#' tags/{tags-name}
#'
#' Interacting with the tags/{tags-name} endpoint of Instagram's API
#'
#' @param tag Name of tag.
#' @param ... Passed to query string.
#' @return Returns tags data.
#' @examples
#' \dontrun{
#' ig_tags <- ig_tags_name()
#' as_tbl(ig_tags)
#' }
#' @export
ig_tags_name <- function(tag = "nofilter", ...) {
  ig_api_get(path = sprintf("tags/%s/", tag), ...)
}

#' tags/search
#'
#' Interacting with the tags/search endpoint of Instagram's API
#'
#' @param q Search query.
#' @param ... Passed to query string.
#' @return Returns tags data.
#' @examples
#' \dontrun{
#' ig_tags <- ig_tags_search()
#' as_tbl(ig_tags)
#' }
#' @export
ig_tags_search <- function(q, ...) {
  ig_api_get(path = "tags/search/", q = q, ...)
}
