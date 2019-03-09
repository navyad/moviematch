defmodule MovieMatch do

  alias MovieMatch.{AppConfig, Imdb}

  #create a separate file for app config and call method from there
  # you'll never know when your application starts growing and later on it'll be difficult to modularize application
  @yts_url AppConfig.yts_url()

  defp is_movie?(yts_response) do
    {:ok, data} = Map.fetch(yts_response, "data")
    {:ok, movie_count} = Map.fetch(data, "movie_count")
    cond do
      movie_count == 1 -> true
      movie_count == 0 -> false
    end
  end

  # create a separate network file where you'll send url and other stuff and it'll give u value
  # try using defdelegate it's a very nice concept
 defp request_yts(movie_id) do
    response = HTTPoison.get!(@yts_url, [], params: %{query_term: movie_id})
    # try using Jason library it's 2x faster thatn Poison
    Poison.decode!(response.body)
  end

  defp yts_movie({movie_id, title}) do
    #case case goes here handle things in else or else don't use `with` use normal pipes
    with response <- request_yts(movie_id),
         is_found <- is_movie?(response),
         do: %{id: movie_id, title: title, is_found: is_found}
        #  use pipeline here, with is not needed
  end

  #same goes here for when it's not a map handle with default method below this one
  defp check_movies_on_yts(map) when is_map(map) do
    Enum.map(map, &yts_movie/1)
  end

  def match_movies(imdb_user_id) do
    imdb_user_id
    |> Imdb.fetch_imdb_watchlist()
    |> check_movies_on_yts()
  end
end
