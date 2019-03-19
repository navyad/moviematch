defmodule MovieMatch do

  require Logger
  alias MovieMatch.{AppConfig, Imdb}

  @yts_url AppConfig.yts_url()

  defp is_movie?(yts_response) do
    {:ok, data} = Map.fetch(yts_response, "data")
    {:ok, movie_count} = Map.fetch(data, "movie_count")
    cond do
      movie_count == 1 -> true
      movie_count == 0 -> false
    end
  end

 defp request_yts(movie_id) do
    Logger.info("movie_id: #{movie_id}")
    params = %{query_term: movie_id}
    response = HTTPoison.get!(@yts_url, [], params: params)
    Poison.decode!(response.body)
  end

  defp yts_movie({movie_id, title}) do
    with {:ok, response} <- MovieMatch.API.get(@yts_url, %{query_term: movie_id}),
         {:success, json_response} <- MovieMatch.API.process_response(response),
         is_found <- is_movie?(json_response),
         do: %{id: movie_id, title: title, is_found: is_found}
  end

  defp check_movies_on_yts(map) when is_map(map) do
    Logger.info("cheking movie with yts: #{@yts_url}")
    Enum.map(map, &yts_movie/1)
  end

  def match_movies(imdb_user_id) do
    imdb_user_id
    |> Imdb.fetch_imdb_watchlist()
    |> check_movies_on_yts()
  end
end
