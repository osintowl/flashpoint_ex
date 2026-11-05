defmodule FlashpointEx.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/yourusername/flashpoint_ex"

  def project do
    [
      app: :flashpoint_ex,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs(),
      name: "FlashpointEx",
      source_url: @source_url
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:req, "~> 0.6"},
      {:jason, "~> 1.4"},
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    Elixir client for Flashpoint Sources API v2. Provides access to threat intelligence
    data including communities, ransomware groups, and dark web markets.
    """
  end

  defp package do
    [
      name: "flashpoint_ex",
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE CHANGELOG.md),
      licenses: ["BSD-3-Clause"],
      links: %{
        "GitHub" => @source_url,
        "Changelog" => "#{@source_url}/blob/main/CHANGELOG.md"
      }
    ]
  end

  defp docs do
    [
      main: "FlashpointEx",
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}",
      source_url: @source_url
    ]
  end
end
