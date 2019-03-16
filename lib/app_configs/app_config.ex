defmodule MovieMatch.AppConfig do
  def yts_url() do
    Application.get_env(:moviematch, :yts_url)
  end
  def imdb_url() do
    Application.get_env(:moviematch, :imdb_url)
  end
end
