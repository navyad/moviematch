defmodule MovieMatch.AppConfig do
  def yts_url(), do: Application.get_env(:moviematch, :yts_url)
end