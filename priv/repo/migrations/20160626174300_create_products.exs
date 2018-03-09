defmodule Kerosene.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :decimal

      timestamps()
    end
  end
end
