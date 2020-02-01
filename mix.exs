defmodule Url.MixProject do
  use Mix.Project

  def project do
    [
      app: :url,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:mongodb, :poolboy],
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      { :uuid, "~> 1.1" },
      { :mongodb, ">= 0.0.0"},
      { :poolboy, ">= 0.0.0" }
    ]
  end
end
