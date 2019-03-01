defmodule  IMDB do

  defp build_url(imdb_user_id) do
    url_parts = ["https:", "", "www.imdb.com", "user", imdb_user_id, "watchlist"]
    Enum.join(url_parts, "/")
  end  

  defp make_request(url) do
    {:ok, response} = HTTPoison.get(url)
    response
  end

  defp parse_html(response) do
    response.body
    |> Floki.find(".ab_widget")
    |> Enum.fetch(0)
    |> elem(1)
    |> elem(2)
    |> Enum.fetch(1)
    |> elem(1)
    |> elem(2)
    |> Enum.fetch(0)
    |> elem(1)
    |> String.split(";\n")
    |> Enum.fetch(4)
    |> elem(1)
  end   

  defp build_json(script_str) do
    script_str
    |> String.trim()
    |> String.replace("IMDbReactInitialState.push(", "")
    |> String.replace(")", "")
    |> String.replace("false", "111")
    |> String.replace("null", "111")
    |> String.replace("\'", "111")
    |> String.replace(")", "")
    |> String.replace("'", "\"")
    |> Poison.decode!()
  end   

  defp id_title({k, v}) do
    with {:ok, primary} = Map.fetch(v, "primary"),
         {:ok, movie_title} = Map.fetch(primary, "title"),
         do: %{k => movie_title} 
  end  

  defp movie_id_titles(map) when is_map(map) do
    {:ok, movie_ids} = Map.fetch(map, "titles")
    Enum.map(movie_ids, &id_title/1)
  end  

  def fetch_imdb_watchlist(imdb_user_id) do
   imdb_user_id
    |> build_url()
    |> make_request()
    |> parse_html()
    |> build_json()
    |> movie_id_titles()
  end  
 end
