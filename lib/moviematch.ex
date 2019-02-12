defmodule MOVIEMATCH do

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

  def movie_titles(json_str) do
    map = Poison.decode!(json_str) |> Map.get("titles")
    Enum.map(map, fn {k, v} -> Map.get(v, "primary") |> Map.get("title")  end)
  end  
end
