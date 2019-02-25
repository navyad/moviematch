defmodule MOVIEMATCH do

  def build_url(imdb_user_id) do
    url_parts = ["https:", "", "www.imdb.com", "user", imdb_user_id, "watchlist"]
    Enum.join(url_parts, "/")
  end  

  def fetch_imdb_watchlist(url) do
    HTTPoison.get(url)
  end

  def parse_html(body) do
    body
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

  def replace(script_str) do
    script_str
    |> String.trim()
    |> String.replace("IMDbReactInitialState.push(", "")
    |> String.replace(")", "")
    |> String.replace("false", "111")
    |> String.replace("null", "111")
    |> String.replace("\'", "111")
    |> String.replace(")", "")
    |> String.replace("'", "\"")
  end   

  def movie_map(json_str) do
    Poison.decode!(json_str)
  end

  defp id_title({k, v}) do
    with {:ok, primary} = Map.fetch(v, "primary"),
         {:ok, movie_title} = Map.fetch(primary, "title"),
         do: %{k => movie_title} 
  end  

  def movie_id_titles(map) when is_map(map) do
    {:ok, movie_ids} = Map.fetch(map, "titles")
    Enum.map(movie_ids, &id_title/1)
  end  
end
