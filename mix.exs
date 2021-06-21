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
    ]
  end

  def application do
    [
      applications: [:httpoison, :floki, :poison]
    ]
  end

  defp description() do
    "Find torrent for movies listed in IMDb's watchlist"
  end

  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:floki, "~> 0.20.0"},
      {:poison, "~> 3.1"},
      {:hackney, github: "benoitc/hackney", override: true}
    ]
  end

  defp package() do
    [
      name: "moviematch",
      maintainers: ["Naveen Yadav"],
      links: %{"GitHub" => "https://github.com/navyad/moviematch"}
    ]
end
end
