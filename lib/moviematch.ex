defmodule MOVIEMATCH do
  import IMDB

 def request_yts(movie_id) do
    url = "https://yts.am/api/v2/list_movies.json?"
    response = HTTPoison.get!(url, [], params: %{query_term: movie_id})
    Poison.decode!(response.body)
  end  


  def match_movies(imdb_user_id) do
    imdb_user_id
    |> IMDB.fetch_imdb_watchlist()
  end  
end
