### MOVIEMATCH

I maintain IMDB watchlist and have repeatedly check yts if movies are available or not, which is mundane activity and time-consuming, yeah I am a bit lazy to do that.
So creating this tiny library which automate that !!

### Usage
1. User's IMDB's watchlist movies. Need to pass IMDB's use_id.
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
2. Match movies with YTS [WIP]
