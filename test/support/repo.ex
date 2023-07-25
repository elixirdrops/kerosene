defmodule Kerosene.Repo do
  use Ecto.Repo,
    otp_app: :kerosene,
    adapter: Ecto.Adapters.Postgres

  use Kerosene, otp_app: :kerosene, per_page: 10
end
