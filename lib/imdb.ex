defmodule MovieMatch.Imdb do

  require Logger
  alias MovieMatch.{AppConfig}

  @imdb_url AppConfig.imdb_url()

  def build_url(imdb_user_id) do
    String.replace(@imdb_url, "imdb_user_id", imdb_user_id)
  end

  defp parse_html({:ok, response}) do
    Logger.info "parsing html..."
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
    Logger.info "building json..."
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
         do: %{id: k, title: movie_title}
    else
      err -> IO.inspect err
  end

  defp movie_id_titles(map) when is_map(map) do
    {:ok, movie_ids} = Map.fetch(map, "titles")
    items = Enum.map(movie_ids, &id_title/1)
    Logger.info("no. of imdb movies: #{length(items)}")
    Enum.reduce(items, %{}, fn e, acc -> Map.put(acc, e.id, e.title) end)
  end

  defp movie_id_titles(_not_map_case) do
    []
  end

  def fetch_imdb_watchlist(imdb_user_id) do
   imdb_user_id
    |> build_url()
    |> MovieMatch.API.get()
    |> parse_html()
    |> build_json()
    |> movie_id_titles()
  end
 end
