defmodule MovieMatch do

  require Logger
  alias MovieMatch.{Imdb}

  @yts_url "https://yts.lt/api/v2/list_movies.json?query_term=movie_id"

  defp yts_respone({:ok, response}, movie_id, title) do
    movie_info = response
      |> Map.get("data")
      |> Map.get("movies")
    %{id: movie_id, title: title, movie_info: movie_info}
  end

  def yts_request({movie_id, title}) do
    url = String.replace(@yts_url, "movie_id", movie_id)
    MovieMatch.API.get(url)
    |> Poison.decode() 
    |> yts_respone(movie_id, title)
  end

  defp check_movies_on_yts(map) when is_map(map) do
    Enum.map(map, &yts_request/1)
  end

  def match_movies(imdb_user_id) do
    imdb_user_id
    |> Imdb.fetch_imdb_watchlist()
    |> check_movies_on_yts()
  end
end
