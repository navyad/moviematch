defmodule MovieMatch.MixProject do
  use Mix.Project

  def project do
    [
      app: :moviematch,
      version: "0.1.0",
      elixir: "~> 1.12.1",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/navyad/moviematch",
      description: description(),
      package: package(),
    ]
  end

  def application do
    [
      applications: [:httpoison, :floki, :poison]
    ]
  end

  defp description() do
    "Find torrents for movies listed in IMDb's watchlist"
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:floki, "~> 0.20.4"},
      {:poison, "~> 3.1"},
    ]
  end

  defp package() do
    [
      name: "moviematch",
      maintainers: ["Naveen Yadav"],
      links: %{"GitHub" => "https://github.com/navyad/moviematch"},
      licenses: ["MIT"],
    ]
end
end
