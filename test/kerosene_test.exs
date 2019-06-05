defmodule KeroseneTest do
  use ExUnit.Case
  alias Kerosene.Repo
  alias Kerosene.Product
  import Ecto.Query

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Kerosene.Repo)
  end

  defp create_products do
    for i <- 1..15 do
      %Product { name: "Product " <> to_string(i), price: 100.00 }
      |> Repo.insert!
    end
  end

  test "offset works correctly" do
    create_products()
    {items, _kerosene} = Product |> Repo.paginate(%{"page" => 2}, per_page: 5)
    items = items |> Enum.sort_by(&(&1.id)) |> Enum.map(&(&1.name))

    assert ["Product 6", "Product 7", "Product 8", "Product 9", "Product 10"] == items
  end

  test "non schema based queries" do
    create_products()
    query =
      from p in "products",
      select: %{id: p.id, name: p.name}

    {_items, kerosene} = Repo.paginate(query, %{})
    assert kerosene.total_count == 15
  end

  test "group_by in query" do
    create_products()
    {_items, kerosene} = Product |> group_by([p], p.id) |> Repo.paginate(%{})
    assert kerosene.total_count == 15
  end

  test "per_page option" do
    create_products()
    {_items, kerosene} = Product |> Repo.paginate(%{}, per_page: 5)
    assert kerosene.per_page == 5
  end

  test "per_page param" do
    create_products()
    {_items, kerosene} = Product |> Repo.paginate(%{"per_page" => 5})
    assert kerosene.per_page == 5
  end

  test "all per_page param" do
    create_products()
    {items, kerosene} = Product |> Repo.paginate(%{"per_page" => "all"})
    assert kerosene.per_page == nil
    assert length(items) == 15
  end

  test "default per_page option" do
    create_products()
    {items, kerosene} = Product |> Repo.paginate(%{}, per_page: nil)
    assert length(items) == 10
    assert kerosene.total_pages == 2
    assert kerosene.total_count == 15
    assert kerosene.per_page == 10
  end

  test "total pages based on per_page" do
    create_products()
    {_items, kerosene} = Product |> Repo.paginate(%{}, per_page: 5)
    assert kerosene.total_pages == 3
  end

  test "default config" do
    create_products()
    {items, kerosene} = Product |> Repo.paginate(%{})
    assert kerosene.total_pages == 2
    assert kerosene.page == 1
    assert length(items) == 10
  end

  test "total_pages calculation" do
    row_count = 100
    per_page = 10
    total_pages = 10
    assert Kerosene.get_total_pages(row_count, per_page) == total_pages
  end

  test "total_count option" do
    create_products()
    {_items, kerosene} = Product |> Repo.paginate(%{}, total_count: 3, per_page: 5)
    assert kerosene.total_count == 3
    assert kerosene.total_pages == 1
  end

  test "max_page constraint" do
    create_products()
    {_items, kerosene} = Product |> Repo.paginate(%{"page" => 100}, total_count: 3, per_page: 5, max_page: 10)
    assert kerosene.total_count == 3
    assert kerosene.total_pages == 1
    assert kerosene.page == 1
  end

  test "use count query when provided total_count is nil" do
    create_products()
    {_items, kerosene} = Product |> Repo.paginate(%{}, total_count: nil, per_page: 5)
    assert kerosene.total_count == 15
    assert kerosene.total_pages == 3
  end

  test "to_integer returns number" do
    assert Kerosene.to_integer(10) == 10
    assert Kerosene.to_integer("10") == 10
    assert Kerosene.to_integer(nil) == 1
  end
end
