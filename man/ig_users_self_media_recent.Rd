% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/users_self.R
\name{ig_users_self_media_recent}
\alias{ig_users_self_media_recent}
\title{users/self/media/recent}
\usage{
ig_users_self_media_recent()
}
\value{
Returns user media data.
}
\description{
Interacting with the users/self/media/recent endpoint of Instagram's API
}
\examples{
\dontrun{
## get your recent media
my_media <- ig_users_self_media_recent()

## view data
ig_as_tbl(my_media)
}
}
