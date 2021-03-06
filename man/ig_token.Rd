% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/oauth.R
\name{ig_token}
\alias{ig_token}
\alias{ig_create_token}
\title{ig_token}
\usage{
ig_token()

ig_create_token(client_id, client_secret, scope = "basic public_content")
}
\arguments{
\item{client_id}{Client key.}

\item{client_secret}{Client secret.}

\item{scope}{Desired scope, defaults to basic and public.}
}
\value{
The user's access token, if available.

Sets environment variable and invisibly returns access token.
}
\description{
Accessing the user's instagram token

Creating access token for interacting with Instagram API
}
