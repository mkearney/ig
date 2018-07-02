


#' ig_token
#'
#' Accessing the user's instagram token
#'
#' @return The user's access token, if available.
#' @export
#' @rdname ig_token
ig_token <- function() {
  if (identical(Sys.getenv("INSTAGRAM_PAT"), "")) {
    stop("Couldn't find access token. See `?ig_create_token()` for ",
      "instructions on setting up and storying your access token.")
  }
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
  path <- gsub("^/", "", path)

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
    dots <- dots[rev(seq_along(dots))]
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

ig_api_get <- function(..., parse = FALSE) {
  ## build and make request
  r <- httr::GET(ig_api_call(...))

  ## check status
  httr::warn_for_status(r)

  ## parsing
  if (parse) {
    if (r$status_code == 200) {
      r <- as_json(r)
    } else {
      r <- as_parsed(r)
    }
  }

  ## return data/response
  r
}

ig_api_post <- function(..., parse = FALSE) {
  ## build and make request
  r <- httr::POST(ig_api_call(...))

  ## check status
  httr::warn_for_status(r)

  ## parsing
  if (parse) {
    if (r$status_code == 200) {
      r <- as_json(r)
    } else {
      r <- as_parsed(r)
    }
  }

  ## return data/response
  invisible(r)
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
  client_id <- gsub("\\s", "", client_id)
  client_secret <- gsub("\\s", "", client_secret)
  Sys.setenv("HTTR_SERVER" = "127.0.0.1")
  Sys.setenv("HTTR_SERVER_PORT" = "1410")
  app <- httr::oauth_app("ig_r_client", client_id, client_secret,
    redirect_uri = "http://127.0.0.1:1410")
  token <- httr::init_oauth2.0(ig_oauth_endpoint(), app,
    scope = "basic public_content")
  set_renv(INSTAGRAM_PAT = token$access_token)
  message("Token created and stored as `INSTAGRAM_PAT` environment variable!",
  " To view your access token, use `ig_token()`.")
  invisible(token)
}

ig_oauth_endpoint <- function() {
  httr::oauth_endpoint(base_url = "https://api.instagram.com/oauth",
    authorize = "authorize", access = "access_token")
}
