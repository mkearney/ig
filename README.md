
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ig

Minimal R client for interacting with Instagram’s public API.

## Installation

You can install *ig* from [Github](https://github.com) with:

``` r
devtools::install_github("mkearney/ig")
```

## Example

Access user data

``` r
## get data from users
me <- ig::ig_users_self()

## view data
me
#> $data
#> $data$id
#> [1] "175176859"
#> 
#> $data$username
#> [1] "mike_waynes_world"
#> 
#> $data$profile_picture
#> [1] "https://scontent.cdninstagram.com/vp/59bd7fd598d38d8428eef2403c989a77/5BE4E3E6/t51.2885-19/s150x150/14499103_1138889339499723_3411021829156896768_a.jpg"
#> 
#> $data$full_name
#> [1] "Mike Kearney"
#> 
#> $data$bio
#> [1] ""
#> 
#> $data$website
#> [1] ""
#> 
#> $data$is_business
#> [1] FALSE
#> 
#> $data$counts
#> $data$counts$media
#> [1] 141
#> 
#> $data$counts$follows
#> [1] 462
#> 
#> $data$counts$followed_by
#> [1] 308
#> 
#> 
#> 
#> $meta
#> $meta$code
#> [1] 200
```
