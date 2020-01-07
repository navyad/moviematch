defmodule MovieMatch.MixProject do
  use Mix.Project

  def project do
    [
      app: :moviematch,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:httpoison, :floki, :poison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:floki, "~> 0.20.0"},
      {:poison, "~> 3.1"},
      {:hackney, github: "benoitc/hackney", override: true}
    ]
  end
end
