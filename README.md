
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ig

Minimal R client for interacting with Instagram’s public API.

## Installation

You can install **{ig}** from [Github](https://github.com) with:

``` r
devtools::install_github("mkearney/ig")
```

## Example

\<\<\<\<\<\<\< HEAD Access Instagram’s **`users/self`** endpoint.
======= Access Instagram’s *`users/self`* endpoint. \>\>\>\>\>\>\>
fd5db518680cec37106c432fec6583b07146cbd9

``` r
## get data from users
me <- ig::ig_users_self()

## view data
me
#> # A tibble: 1 x 10
#>   id    username profile_picture full_name bio   website is_business media
#>   <chr> <chr>    <chr>           <chr>     <chr> <chr>   <lgl>       <int>
#> 1 1751… mike_wa… https://sconte… Mike Kea… ""    ""      FALSE         141
#> # ... with 2 more variables: follows <int>, followed_by <int>
```
