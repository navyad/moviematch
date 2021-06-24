defmodule MovieMatch do

  require Logger
  alias MovieMatch.{Imdb}

  @yts_url "https://yts.lt/api/v2/list_movies.json?query_term=query_term_val"

  defp is_movie?({:ok, yts_response}) do
    Logger.info("checking yts response..")
    {:ok, data} = Map.fetch(yts_response, "data")
    {:ok, movie_count} = Map.fetch(data, "movie_count")
    movie_count > 0 
  end

  def yts_movie({movie_id, title}) do
    url = String.replace(@yts_url, "query_term_val", movie_id)
    is_found = MovieMatch.API.get(url)
               |> Poison.decode() 
               |>is_movie?()
     %{id: movie_id, title: title, is_found: is_found}
  end

  defp check_movies_on_yts(map) when is_map(map) do
    Enum.map(map, &yts_movie/1)
  end

  def match_movies(imdb_user_id) do
    imdb_user_id
    |> Imdb.fetch_imdb_watchlist()
    |> check_movies_on_yts()
  end
end
