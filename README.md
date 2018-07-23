
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ig <img src="man/figures/logo.png" width="160px" align="right" />

> 🖼 A minimal R client for interacting with Instagram’s public API.

## Installation

You can install **{ig}** from [Github](https://github.com) with:

``` r
devtools::install_github("mkearney/ig")
```

## Authorization

To become authorized to interact with Instagram’s API, users must first
[go here and create an Instagram
app](https://www.instagram.com/developer). Once you’ve created an app,
copy the **`Client ID`** and **`Client Secret`** keys<sup>1</sup> from
the app’s page and pass them along to `ig_create_token()`.

``` r
## use client_id and client_secret to create and save access token
ig_create_token("pb112zgv5065tu60pxnqvp88f6hovbur", 
  "drz97x61d9s5g2nlcu87v63mdphiedcv")
```

It’s not necessary to specify your token in each request (***ig***
functions actually do that in the background for you), but if you’d like
to view your access token, use `ig_token()`.

``` r
## view your access token
ig_token()
#>                                         access_token 
#> "877861763.6001s28.4d8i211p0sf942o0394x5d4kwdk831l1" 
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
ig_as_tbl(me)
#>  $ meta
#>    $ code: 200
#>  $ data
#>    $ class: list
#>    $ dims: 8
#> # A tibble: 1 x 7
#>   id     username  profile_picture     full_name bio   website is_business
#>   <chr>  <chr>     <chr>               <chr>     <chr> <chr>   <lgl>      
#> 1 17517… mike_way… https://scontent.c… Mike Kea… ""    ""      FALSE
```

### `users/self/media/recent`

``` r
## get your media data
my_media <- ig_users_self_media_recent()

## view data
ig_as_tbl(my_media)
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
ig_tags <- ig_tags(tag = "metoo")

## view data
ig_as_tbl(ig_tags)
#>  $ meta
#>    $ code: 200
#>  $ data
#>    $ class: list
#>    $ dims: 2
#> # A tibble: 1 x 2
#>   name  media_count
#>   <chr>       <int>
#> 1 metoo     1247390
```

### `tags/search`

``` r
## search tags data
ig_tags <- ig_tags_search(q = "metoo")

## view data
ig_as_tbl(ig_tags)
#>  $ meta
#>    $ code: 200
#>  $ data
#>    $ class: data.frame
#>    $ dims: 50 obs x 2 vars
#> # A tibble: 50 x 2
#>    name              media_count
#>  * <chr>                   <int>
#>  1 metoo                 1247390
#>  2 metoo❤️                 25948
#>  3 metootoys                4472
#>  4 metoomovement           26865
#>  5 metoodoll               27522
#>  6 metoodolls              10114
#>  7 metooo                   2392
#>  8 metooangela             10270
#>  9 metoobuddy               3334
#> 10 sheknowsmetoowell       41379
#> # ... with 40 more rows
```

## Additional endpoints

To send requests to additional endpoints, supply the path and any
relevant query parameters to either `ig_api_get()` or `ig_api_post()`.

``` r
## make custom request to locations/search endpoint
ig_locs <- ig_api_get("locations/search", lat = 48.858844, lng = 2.294351)

## view data
ig_as_tbl(ig_locs)
#>  $ meta
#>    $ code: 200
#>  $ data
#>    $ class: data.frame
#>    $ dims: 20 obs x 4 vars
#> # A tibble: 20 x 4
#>    id            name                                   latitude longitude
#>  * <chr>         <chr>                                     <dbl>     <dbl>
#>  1 2593354       Tour Eiffel                                48.9      2.29
#>  2 104259689917… Effile Tower Paris                         48.9      2.30
#>  3 6889842       Paris, France                              48.9      2.35
#>  4 808217352699… Eiffel Tower                               48.9      2.30
#>  5 6889842       Paris, France                              48.9      2.35
#>  6 767158323476… Eiffel Tower, Paris                        48.9      2.30
#>  7 213790743     58 Tour Eiffel                             48.9      2.29
#>  8 389164438201… Tour Eiffel France.                        48.9      2.29
#>  9 372828359     Ile-de-France, France                      48.7      2.71
#> 10 34181412      Arc de Triomphe                            48.9      2.30
#> 11 791265207706… Torre Eiffel                               48.9      2.30
#> 12 299202480461… Le Jules Verné Michelin Paris              48.9      2.29
#> 13 521850351502… Torre eiffel                               48.9      2.30
#> 14 432536411     Dinner At 58 Tour Eiffel Tower, Paris…     48.9      2.29
#> 15 467705676894… Le Jules Verne Par Alain Ducasse, Tou…     48.9      2.30
#> 16 151174985     Avenue des Champs-Élysées                  48.9      2.30
#> 17 300550090365… Cruise on the River Seine                  48.9      2.29
#> 18 263520440857… Longines Paris Eiffel Jumping              48.9      2.29
#> 19 193639175994… Place du Trocadéro                         48.9      2.29
#> 20 309248170     Top Of Eiffel Tower                        48.9      2.31
```

<sup>1</sup> *NOTE*: All keys provided in examples are fake but are
otherwise designed to appear similar to the actual keys assigned by
Instagram.
