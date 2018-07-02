

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


#' Create ig_token
#'
#' Creating access token for interacting with Instagram API
#'
#' @param client_id Client key.
#' @param client_secret Client secret.
#' @param scope Desired scope, defaults to basic and public.
#' @return Sets environment variable and invisibly returns access token.
#' @rdname ig_token
#' @export
ig_create_token <- function(client_id, client_secret, scope = "basic public_content") {
  client_id <- gsub("\\s", "", client_id)
  client_secret <- gsub("\\s", "", client_secret)
  scope <- paste(scope, collapse = " ")
  Sys.setenv("HTTR_SERVER" = "127.0.0.1")
  Sys.setenv("HTTR_SERVER_PORT" = "1410")
  app <- httr::oauth_app("ig_r_client", client_id, client_secret,
    redirect_uri = "http://127.0.0.1:1410")
  token <- httr::init_oauth2.0(ig_oauth_endpoint(), app, scope = scope)
  set_renv(INSTAGRAM_PAT = token$access_token)
  message("Token created and stored as `INSTAGRAM_PAT` environment variable!",
    " To view your access token, use `ig_token()`.")
  invisible(token)
}

ig_oauth_endpoint <- function() {
  httr::oauth_endpoint(base_url = "https://api.instagram.com/oauth",
    authorize = "authorize", access = "access_token")
}
