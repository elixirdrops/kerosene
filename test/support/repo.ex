defmodule Kerosene.Repo do
  use Ecto.Repo, otp_app: :kerosene
  use Kerosene, otp_app: :kerosene, per_page: 10
end
