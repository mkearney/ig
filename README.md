
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ig

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

It’s not necessary to specify your token in each request (***ig***)
actually does that in the background), but if you’d like to view your
access token, use `ig_token()`.

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
#>   id        username  profile_picture  full_name bio   website is_business
#>   <chr>     <chr>     <chr>            <chr>     <chr> <chr>   <lgl>      
#> 1 175176859 mike_way… https://sconten… Mike Kea… ""    ""      FALSE
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
#> 1 metoo     1211579
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
#>  1 metoo                 1211579
#>  2 metootoys                4408
#>  3 metoo❤️                 25470
#>  4 metoodoll               26903
#>  5 metoodolls               9878
#>  6 metooo                   2377
#>  7 metoomovement           24412
#>  8 metooangela             10131
#>  9 metoobuddy               3281
#> 10 sheknowsmetoowell       41120
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
#>    id               name                                latitude longitude
#>  * <chr>            <chr>                                  <dbl>     <dbl>
#>  1 2593354          Tour Eiffel                             48.9      2.29
#>  2 1042596899175884 Effile Tower Paris                      48.9      2.30
#>  3 6889842          Paris, France                           48.9      2.35
#>  4 6889842          Paris, France                           48.9      2.35
#>  5 213790743        58 Tour Eiffel                          48.9      2.29
#>  6 372828359        Ile-de-France, France                   48.7      2.71
#>  7 151174985        Avenue des Champs-Élysées               48.9      2.30
#>  8 1356688971082840 58 Eiffel Tower Restaurant              48.8      2.34
#>  9 32251308         Champs Elysees Paris                    48.9      2.30
#> 10 299202480461728  Le Jules Verné Michelin Paris           48.9      2.29
#> 11 238585647        Trocadéro (Paris Métro)                 48.9      2.29
#> 12 309248170        Top Of Eiffel Tower                     48.9      2.31
#> 13 432536411        Dinner At 58 Tour Eiffel Tower, Pa…     48.9      2.29
#> 14 300550090365446  Cruise on the River Seine               48.9      2.29
#> 15 350884335313484  Eiffel Tower, Paris, Fransa             48.7      2.26
#> 16 1936391759949191 Place du Trocadéro                      48.9      2.29
#> 17 375269519489153  Paris                                  -20.2    -70.2 
#> 18 1567826363500627 Saint Germain                           48.9      2.33
#> 19 467705676894039  Le Jules Verne Par Alain Ducasse, …     48.9      2.30
#> 20 290297           Musée du quai Branly - Jacques Chi…     48.9      2.30
```

<sup>1</sup> *NOTE*: All keys provided in examples are fake but are
otherwise designed to appear similar to the actual keys assigned by
Instagram.
