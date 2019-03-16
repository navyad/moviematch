# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :moviematch, 
  imdb_url: "https://www.imdb.com/user/imdb_user_id/watchlist", 
  yts_url:  "https://yts.am/api/v2/list_movies.json"

config :logger,
  backends: [:console]
