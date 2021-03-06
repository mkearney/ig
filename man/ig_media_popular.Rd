% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tags_media.R
\name{ig_media_popular}
\alias{ig_media_popular}
\title{media/popular}
\usage{
ig_media_popular()
}
\value{
Returns user data.
}
\description{
Interacting with the media/popular endpoint of Instagram's API
}
\examples{
\dontrun{
## get popular media
pop <- ig_media_popular()

## view data
ig_as_tbl(pop)
}
}
