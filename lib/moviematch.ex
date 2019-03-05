defmodule MOVIEMATCH do
  import IMDB

  defp is_movie?(yts_response) do
    {:ok, data} = Map.fetch(yts_response, "data")
    {:ok, movie_count} = Map.fetch(data, "movie_count")
    cond do
      movie_count == 1 -> true
      movie_count == 0 -> false  
    end    
  end   

 defp request_yts(movie_id) do
    url = "https://yts.am/api/v2/list_movies.json?"
    response = HTTPoison.get!(url, [], params: %{query_term: movie_id})
    Poison.decode!(response.body)
  end  

  defp yts_movie({movie_id, title}) do
    with response <- request_yts(movie_id), 
         is_found <- is_movie?(response),
         do: %{id: movie_id, title: title, is_found: is_found}
  end

  defp check_movies_on_yts(map) when is_map(map) do
    Enum.map(map, &yts_movie/1)  
  end

  def match_movies(imdb_user_id) do
    imdb_user_id
    |> fetch_imdb_watchlist()
    |> check_movies_on_yts() 
  end  
end
