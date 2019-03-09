defmodule MovieMatch.Imdb do

  @imdb_url Application.get_env(:moviematch, :imdb_url)

  def build_url(imdb_user_id) do
    String.replace(@imdb_url, "imdb_user_id", imdb_user_id)
  end

  defp make_request(url) do
    # try using tesla library also, HTTPoison and HTTPotion has some limitations
    #what if it's not :ok? try handling in case
    case HTTPoison.get(url) do
      {:ok, response} -> response
      {:error, msg} -> msg
    end
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
    #handle error cases also with else syntax in `with` otherwise there
    #is no proper use case of using it, we can directly use pipe if you are not handling else cases
    # I have given example below, in case you are fully sure that this value is gonna be there then you can directly use v["primary"] or Aceess.get(v, "primary")
    # usually when
    with {:ok, primary} = Map.fetch(v, "primary"),
         {:ok, movie_title} = Map.fetch(primary, "title"),
         do: %{id: k, title: movie_title}
  # else
  #   {:error} <- "something"
  #   _ <- "something"
  # end
  end

  # what if this is not a map? where is other case?
  defp movie_id_titles(map) when is_map(map) do
    #don't use ok syntax unless you are handling error , you can directly use
    # movie_ids = map["titles"] || "in case null you can give default like this"
    {:ok, movie_ids} = Map.fetch(map, "titles")
    items = Enum.map(movie_ids, &id_title/1)
    Enum.reduce(items, %{}, fn e, acc -> Map.put(acc, e.id, e.title) end)
  end

  #handle here otherwise it'll say that pattern not found otherwise dont' check in function above that it's a map or not
  defp movie_id_titles(_not_map_case) do
    []
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
