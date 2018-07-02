


#' ig_token
#' 
#' Accessing the user's instagram token
#' 
#' @return The user's access token, if available.
#' @export
#' @rdname ig_token
ig_token <- function() {
  structure(Sys.getenv("INSTAGRAM_PAT"), names = "access_token")
}

ig_api_call <- function(...) {
  ## capture dots
  dots <- list(...)

  ## base url: if missing, set to default
  if (!"base_url" %in% names(dots)) {
    base_url <- "https://api.instagram.com/v1"
  } else {
    base_url <- dots$base_url
    dots$base_url <- NULL
  }
  base_url <- sub("/$", "", base_url)

  ## path: assume first unnamed arg; if missing, set to empty
  if ("path" %in% names(dots)) {
    path <- dots$path
    dots$path <- NULL
  } else if (length(dots) > 0 &&
      (is.null(names(dots)) || identical(names(dots)[1], ""))) {
    path <- dots[1]
    dots <- dots[-1]
  } else {
    path <- ""
  }
  path <- gsub("^/|/$", "", path)

  ## build url
  if (!identical(path, "")) {
    url <- paste0(base_url, "/", path)
  } else {
    url <- base_url
  }

  ## if query/params sent as list, unlist
  if (length(dots) == 1L && is.list(dots[[1]])) {
    dots <- dots[[1]]
  }
  
  ## base url: if missing, set to default
  if (!"access_token" %in% names(dots) && 
    !identical(Sys.getenv("INSTAGRAM_PAT"), "")) {
    dots$access_token <- ig_token()
  } else {
    stop("expected to find `access_token` in query string")
  }

  ## if params provided, enter params
  if (length(dots) > 0L) {
    dots <- paste0(names(dots), "=", dots)
    dots <- paste(dots, collapse = "&")
    url <- paste0(url, "?", dots)
  }

  ## return url
  url
}

ig_api_get <- function(...) {
  ## build and make request
  r <- httr::GET(ig_api_call(...))
  
  ## check status
  httr::warn_for_status(r)
  
  ## if status is clear then parse
  if (r$status_code == 200) {
    r <- jsonlite::fromJSON(httr::content(r, as = "text", encoding = "UTF-8"))
  }
  
  ## return data/response
  r
}

ig_api_post <- function(...) {
  ## build and make request
  r <- httr::POST(ig_api_call(...))
  
  ## check status
  httr::warn_for_status(r)
  
  ## if status is clear then parse
  if (r$status_code == 200) {
    r <- jsonlite::fromJSON(httr::content(r, as = "text", encoding = "UTF-8"))
  }
  
  ## return data/response
  invisible(r)
}

as_tbl <- function(...) {
  tibble::as_tibble(..., validate = FALSE)
}

`%||%` <- function(a, b) a || isTRUE(tryCatch(`(`(b), error = function(e) return(FALSE)))

#' users/self
#' 
#' Interacting with the users/self endpoint of Instagram's API
#' 
#' @return Returns user data.
#' @examples
#' \dontrun{
#' my_ig <- ig_users_self()
#' my_ig 
#' }
#' @export 
ig_users_self <- function() {
  r <- ig_api_get(path = "users/self")
  as_tbl(c(r$data[!names(r$data) %in% "counts"], r$data$counts))
}


ig_oauth_endpoint <- function() {
  httr::oauth_endpoint(base_url = "https://api.instagram.com/oauth",
    authorize = "authorize", access = "access_token")
}

#' Create ig_token
#' 
#' Creating access token for interacting with Instagram API
#' 
#' @param client_id Client key.
#' @param client_secret Client secret.
#' @return Sets environment variable and invisibly returns access token.
#' @rdname ig_token
#' @export
ig_create_token <- function(client_id, client_secret) {
  app <- httr::oauth_app("ig_r_client", client_id, client_secret,
    redirect_uri = "http://127.0.0.1:1410")
  token <- httr::oauth2.0_token(ig_oauth_endpoint(), app, cache = FALSE)
  rtweet:::set_renv(INSTAGRAM_PAT = token$credentials$access_token)
  message("Token created and stored as `INSTAGRAM_PAT` environment variable! To view your access token, use `ig_token()`.")
  invisible(token$credentials$access_token)
}
