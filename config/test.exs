use Mix.Config

config :kerosene, ecto_repos: [Kerosene.Repo]

config :kerosene, Kerosene.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "kerosene_dev",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# shut up only log errors
config :logger, :console, level: :error
