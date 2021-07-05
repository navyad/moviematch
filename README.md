### MovieMatch

I maintain IMDB watchlist and have repeatedly check yts if movies are available or not, which is mundane activity and time-consuming, yeah I am a bit lazy to do that.
So creating this tiny library which automate that !!

### Prerequisites
```elixir  v1.12.1```

### Installation
the package can be installed by adding `moviematch` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:moviematch, "~> 0.1.0"}
  ]
end
```

### Usage
1. Get IMDB's watchlist movies of user having user_id as ```ur26610840```.
```
iex(1)> MovieMatch.Imdb.fetch_imdb_watchlist("ur26610840")
```
results
```
%{
  "tt1034415" => "Suspiria",
  "tt1502407" => "Halloween",
  "tt3986820" => "The Endless",
  "tt4003440" => "The House That Jack Built",
  "tt4015500" => "The Tale",
  "tt4645368" => "Juste la fin du monde",
  "tt5116410" => "Tower",
  "tt5160938" => "Lizzie",
  "tt5516328" => "Ghost Stories",
  "tt5607096" => "Juliet, Naked",
  "tt5886440" => "Marrowbone",
  "tt5989218" => "Life Itself",
  "tt6053438" => "First Reformed",
  "tt6628394" => "Bad Times at the El Royale",
  "tt6823368" => "Glass",
  "tt6998518" => "Mandy",
  "tt7349950" => "It: Chapter Two",
  "tt8359848" => "Climax"
}
```
2. Match movies with YTS
```
 iex(2)> MovieMatch.match_movies("ur26610840")
 ```
Movie information if movie found on YTS
 ```
 %{
    id: "tt9601220",
    movie_info: [
      %{
        "background_image" => "https://yts.mx/assets/images/movies/black_bear_2020/background.jpg",
        "background_image_original" => "https://yts.mx/assets/images/movies/black_bear_2020/background.jpg",
        "date_uploaded" => "2020-12-04 12:16:44",
        "date_uploaded_unix" => 1607080604,
        "description_full" => "At a remote lake house in the Adirondack Mountains, a couple entertains an out-of-town guest looking for inspiration in her filmmaking. The group quickly falls into a calculated game of desire, manipulation, and jealousy, unaware of how dangerously convoluted their lives will soon become in the filmmaker's pursuit of a work of art, which blurs the boundaries between autobiography and invention. —kanaan-02150",
        "genres" => ["Action", "Comedy", "Drama"],
        "id" => 24473,
        "imdb_code" => "tt9601220",
        "language" => "en",
        "large_cover_image" => "https://yts.mx/assets/images/movies/black_bear_2020/large-cover.jpg",
        "medium_cover_image" => "https://yts.mx/assets/images/movies/black_bear_2020/medium-cover.jpg",
        "mpa_rating" => "R",
        "rating" => 6.6,
        "runtime" => 104,
        "slug" => "black-bear-2020",
        "small_cover_image" => "https://yts.mx/assets/images/movies/black_bear_2020/small-cover.jpg",
        "state" => "ok",
        "summary" => "At a remote lake house in the Adirondack Mountains, a couple entertains an out-of-town guest looking for inspiration in her filmmaking. The group quickly falls into a calculated game of desire, manipulation, and jealousy, unaware of how dangerously convoluted their lives will soon become in the filmmaker's pursuit of a work of art, which blurs the boundaries between autobiography and invention. —kanaan-02150",
        "synopsis" => "At a remote lake house in the Adirondack Mountains, a couple entertains an out-of-town guest looking for inspiration in her filmmaking. The group quickly falls into a calculated game of desire, manipulation, and jealousy, unaware of how dangerously convoluted their lives will soon become in the filmmaker's pursuit of a work of art, which blurs the boundaries between autobiography and invention. —kanaan-02150",
        "title" => "Black Bear",
        "title_english" => "Black Bear",
        "title_long" => "Black Bear (2020)",
        "torrents" => [
          %{
            "date_uploaded" => "2020-12-04 12:16:44",
            "date_uploaded_unix" => 1607080604,
            "hash" => "D28ADC2C9475FD41327BF15F25BFE423FB60E03F",
            "peers" => 3,
            "quality" => "720p",
            "seeds" => 16,
            "size" => "971.12 MB",
            "size_bytes" => 1018293125,
            "type" => "web",
            "url" => "https://yts.mx/torrent/download/D28ADC2C9475FD41327BF15F25BFE423FB60E03F"
          },
          %{
            "date_uploaded" => "2020-12-04 13:36:28",
            "date_uploaded_unix" => 1607085388,
            "hash" => "1491B008F45036F13B60800A4A928E8B65765957",
            "peers" => 3,
            "quality" => "1080p",
            "seeds" => 22,
            "size" => "1.95 GB",
            "size_bytes" => 2093796557,
            "type" => "web",
            "url" => "https://yts.mx/torrent/download/1491B008F45036F13B60800A4A928E8B65765957"
          }
        ],
        "url" => "https://yts.mx/movies/black-bear-2020",
        "year" => 2020,
        "yt_trailer_code" => "D7XVArQc7z8"
      }
    ],
```

Movie information if movie not found on YTS
```
%{id: "tt9639470", movie_info: nil, title: "Last Night in Soho"}
```
