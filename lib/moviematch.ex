defmodule MOVIEMATCH do

  def fetch_imdb_watchlist(url) do
    HTTPoison.get(url)
  end

  def parse_html(body) do
    ad_widget = Floki.find(body, ".ab_widget")
    block = Enum.fetch(ad_widget, 0)
    t1 = elem(block, 1)
    t2 = Enum.fetch(elem(t1, 2), 1)
    t3 = elem(t2, 1)
    t4 = elem(t3, 2)
    t5 = Enum.fetch(t4, 0)
    t6 = elem(t5, 1)
    t7 = Enum.fetch(String.split(t6, ";\n"), 4)
    t8 = elem(t7, 1)
  end   

  def build_map(script_str) do
    script_str = String.replace_leading(script_str, "        IMDbReactInitialState.push(", "")
    script_str = String.replace_leading(script_str, ")", "")
    script_str = String.replace(script_str, "false", "111")
    script_str = String.replace(script_str, "null", "111")
    script_str = String.replace(script_str, "\'", "111")
    script_str =  String.replace(script_str, ")", "")
    script_str |> String.replace("'", "\"") |> Poison.decode!
  end  
end
