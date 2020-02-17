defmodule UrlShortener.MixProject do
  use Mix.Project

  def project do
    [
      app: :url_shortener,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:logger, :plug_cowboy],
      mod: {
        UrlShortener.Application,
        []
      },
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:uuid, "~> 1.1"},
      {:redix, ">= 0.0.0"},
      {:castore, ">= 0.0.0"},
      {:plug_cowboy, ">= 0.0.0"},
      {:poison, ">= 0.0.0"}
    ]
  end
end
