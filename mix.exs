defmodule Kerosene.Mixfile do
  use Mix.Project
  @version "0.7.0"

  def project do
    [app: :kerosene,
     version: @version,
     elixir: "~> 1.2",
     elixirc_paths: path(Mix.env),
     package: package(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     aliases: aliases(),
     name: "Kerosene",
     docs: [source_ref: "v#{@version}", main: "Kerosene"],
     source_url: "https://github.com/elixirdrops/kerosene",
     description: """
     Pagination for Ecto and Phoenix.
     """]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: application(Mix.env)]
  end
  defp application(:test), do: [:postgrex, :ecto, :logger]
  defp application(_), do: [:logger]

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:phoenix_html, "~> 2.6"},
     {:plug, "~> 1.0"},
     {:ecto, "~> 2.0"},
     # Test dependencies
     {:postgrex, "~> 0.12.0", only: [:test]},
     # Docs dependencies
     {:earmark, "~> 0.1", only: :docs},
     {:ex_doc, "~> 0.11", only: :docs},
     {:inch_ex, "~> 0.2", only: :docs}]
  end

  defp path(:test) do
    ["lib", "test/support", "test/fixtures"]
  end
  defp path(_), do: ["lib"]

  defp package do
    [maintainers: ["Ally Raza"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/elixirdrops/kerosene"},
     files: ~w(lib test config) ++
            ~w(CHANGELOG.md LICENSE.md mix.exs README.md)]
  end

  def aliases do
    ["test": ["ecto.create --quite", "ecto.migrate --quite", "test"]]
  end
end
