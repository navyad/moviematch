### MOVIEMATCH

I maintain IMDB watchlist and have repeatedly check yts if movies are available or not, which is mundane activity and time-consuming, yeah I am a bit lazy to do that.
So creating this tiny library which automate that !!

### Prerequisites
```elixir  v1.7+```


### Usage
1. Get IMDB's watchlist movies of user having user_id as ```ur26610840```.
```
iex(1)> IMDB.fetch_imdb_watchlist("ur26610840")
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
 iex(2)> MOVIEMATCH.match_movies("ur26610840")
 ```
 results
 ```
 [
  %{id: "tt1034415", is_found: true, title: "Suspiria"},
  %{id: "tt1502407", is_found: true, title: "Halloween"},
  %{id: "tt3986820", is_found: true, title: "The Endless"},
  %{id: "tt4003440", is_found: true, title: "The House That Jack Built"},
  %{id: "tt4015500", is_found: false, title: "The Tale"},
  %{id: "tt4645368", is_found: false, title: "Juste la fin du monde"},
  %{id: "tt5116410", is_found: false, title: "Tower"},
  %{id: "tt5160938", is_found: true, title: "Lizzie"},
  %{id: "tt5516328", is_found: true, title: "Ghost Stories"},
  %{id: "tt5607096", is_found: true, title: "Juliet, Naked"},
  %{id: "tt5886440", is_found: true, title: "Marrowbone"},
  %{id: "tt5989218", is_found: true, title: "Life Itself"},
  %{id: "tt6053438", is_found: true, title: "First Reformed"},
  %{id: "tt6628394", is_found: true, title: "Bad Times at the El Royale"},
  %{id: "tt6823368", is_found: false, title: "Glass"},
  %{id: "tt6998518", is_found: true, title: "Mandy"},
  %{id: "tt7349950", is_found: false, title: "It: Chapter Two"},
  %{id: "tt8359848", is_found: true, title: "Climax"}
]
```

### Contributing
If you would have an interesting idea how to improve the operation of this tool, or if you found some errors - fork this, add your fixes, and add a pull request of your branch to the master branch.
