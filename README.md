
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ig

Minimal R client for interacting with Instagram’s public API.

## Installation

You can install **{ig}** from [Github](https://github.com) with:

``` r
devtools::install_github("mkearney/ig")
```

## Authorization

To become authorized to interact with Instagram’s API, users must first
[go here and create an Instagram
app](https://www.instagram.com/developer). Once you’ve created an app,
copy the **`Client ID`** and **`Client Secret`** keys from the app’s
page and pass them along to `ig_create_token()`.

``` r
## use client_id and client_secret to create and save access token
ig_create_token("pb112zgv5065tu60pxnqvp88f6hovbur", 
  "drz97x61d9s5g2nlcu87v63mdphiedcv")

## view your access token
ig_token()
```

The rest of the token process is automated for you (you don’t need to
reference it again).

## Endpoints

There are numerous API endpoints, but thanks to recent changes by
Instagram, most users won’t get access to large amounts of public data
(at least not without first going through a strict submission process).
Here are some that should still work though:

### `users/self`

``` r
## get your instagram data
me <- ig_users_self()

## view data
as_tbl(me)
#>  $ meta
#>    $ code: 200
#>  $ data
#>    $ class: list
#>    $ dims: 8
#> # A tibble: 1 x 7
#>   id        username  profile_picture  full_name bio   website is_business
#>   <chr>     <chr>     <chr>            <chr>     <chr> <chr>   <lgl>      
#> 1 175176859 mike_way… https://sconten… Mike Kea… ""    ""      FALSE
```

### `users/self/media/recent`

``` r
## get your media data
my_media <- ig_users_self_media_recent()

## view data
as_tbl(my_media)
#>  $ pagination
#>    $ :
#>  $ meta
#>    $ code: 200
#>  $ data
#>    $ class: data.frame
#>    $ dims: 20 obs x 17 vars
#> # A tibble: 20 x 7
#>    id      created_time user_has_liked filter  type  link      attribution
#>  * <chr>   <chr>        <lgl>          <chr>   <chr> <chr>     <lgl>      
#>  1 180444… 1529326616   FALSE          Mayfair image https://… NA         
#>  2 179014… 1527621830   FALSE          Normal  caro… https://… NA         
#>  3 179013… 1527620656   FALSE          Aden    image https://… NA         
#>  4 178929… 1527520024   FALSE          Normal  caro… https://… NA         
#>  5 176788… 1524968858   FALSE          Normal  caro… https://… NA         
#>  6 176336… 1524428978   FALSE          Reyes   image https://… NA         
#>  7 175704… 1523676268   FALSE          Crema   image https://… NA         
#>  8 175306… 1523201331   FALSE          Normal  image https://… NA         
#>  9 174821… 1522623997   FALSE          X-Pro … image https://… NA         
#> 10 174766… 1522558145   FALSE          X-Pro … image https://… NA         
#> 11 174614… 1522376529   FALSE          Normal  image https://… NA         
#> 12 174610… 1522372473   FALSE          Crema   image https://… NA         
#> 13 174289… 1521989375   FALSE          Normal  caro… https://… NA         
#> 14 157920… 1502475629   FALSE          Hudson  image https://… NA         
#> 15 157561… 1502047616   FALSE          Normal  image https://… NA         
#> 16 156859… 1501210853   FALSE          Juno    image https://… NA         
#> 17 151477… 1494795791   FALSE          Sierra  video https://… NA         
#> 18 139544… 1480569623   FALSE          X-Pro … image https://… NA         
#> 19 134541… 1474605839   FALSE          Sierra  image https://… NA         
#> 20 125735… 1464108928   FALSE          Normal  image https://… NA
```

### `tags/{tags-name}`

``` r
## get tags data
ig_tags <- ig_tags_name(tag = "metoo")

## view data
as_tbl(ig_tags)
#>  $ meta
#>    $ code: 200
#>  $ data
#>    $ class: list
#>    $ dims: 2
#> # A tibble: 1 x 2
#>   name  media_count
#>   <chr>       <int>
#> 1 metoo     1210871
```

### `tags/search`

``` r
## search tags data
ig_tags <- ig_tags_search(q = "metoo")

## view data
as_tbl(ig_tags)
#>  $ meta
#>    $ code: 200
#>  $ data
#>    $ class: data.frame
#>    $ dims: 50 obs x 2 vars
#> # A tibble: 50 x 2
#>    name              media_count
#>  * <chr>                   <int>
#>  1 metoo                 1210871
#>  2 metootoys                4405
#>  3 metoo❤️                 25443
#>  4 metoodoll               26877
#>  5 metoodolls               9874
#>  6 metooo                   2376
#>  7 metoomovement           24356
#>  8 metooangela             10131
#>  9 metoobuddy               3280
#> 10 sheknowsmetoowell       41118
#> # ... with 40 more rows
```
