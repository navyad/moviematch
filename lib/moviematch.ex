defmodule MovieMatch do

  require Logger
  alias MovieMatch.{Imdb}

  @yts_url "https://yts.lt/api/v2/list_movies.json?query_term=movie_id"

  defp yts_respone({:ok, response}) do
    {:ok, data} = Map.fetch(response, "data")
    Map.get(data, "movies")
  end

  def yts_request({movie_id, title}) do
    url = String.replace(@yts_url, "movie_id", movie_id)
    Logger.info(url)
    torrents = MovieMatch.API.get(url)
               |> Poison.decode() 
               |> yts_respone()
     %{id: movie_id, title: title, torrents: torrents}
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
