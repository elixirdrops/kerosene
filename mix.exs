defmodule Kerosene.Mixfile do
  use Mix.Project

  @source_url "https://github.com/elixirdrops/kerosene"
  @version "0.9.0"

  def project do
    [
      app: :kerosene,
      version: @version,
      elixir: "~> 1.2",
      name: "Kerosene",
      elixirc_paths: path(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      docs: docs(),
      aliases: aliases(),
      preferred_cli_env: preferred_cli_env()
    ]
  end

  def application do
    [
      applications: application(Mix.env())
    ]
  end

  defp application(:test), do: [:postgrex, :ecto, :logger]
  defp application(_), do: [:logger]

  defp deps do
    [
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:ex_doc, ">= 0.0.0", only: :docs, runtime: false},
      {:inch_ex, "~> 0.2", only: :docs, runtime: false},
      {:phoenix_html, "~> 2.10"},
      {:plug, "~> 1.4"},
      {:postgrex, "~> 0.14.0", only: [:test]}
    ]
  end

  defp path(:test) do
    ["lib", "test/support", "test/fixtures"]
  end

  defp path(_), do: ["lib"]

  defp package do
    [
      description: "Pagination for Ecto and Phoenix.",
      maintainers: ["Ally Raza"],
      licenses: ["MIT"],
      files:
        ~w(lib test config) ++
          ~w(CHANGELOG.md LICENSE.md mix.exs README.md),
      links: %{
        GitHub: @source_url
      }
    ]
  end

  defp aliases do
    [
      test: ["ecto.create --quite", "ecto.migrate --quite", "test"]
    ]
  end

  defp preferred_cli_env do
    [
      docs: :docs
    ]
  end

  defp docs do
    [
      extras: [
        "CHANGELOG.md": [title: "Changelog"],
        "LICENSE.md": [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_ref: "v#{@version}",
      formatters: ["html"]
    ]
  end
end
