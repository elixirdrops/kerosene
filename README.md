# Kerosene

Pagination for Ecto and Phoenix.

This is a fork of the original [Kerosene](https://github.com/elixirdrops/kerosene), which seems to have been abandoned :(

Another good fork to consider - [Dissolver](https://github.com/MorphicPro/dissolver)... or any of the other pagination libraries that came up since Kerosene was created!

## Installation

The package is [available in Hex](https://hex.pm/packages/kerosene), the package can be installed as:

Add kerosene to your list of dependencies in `mix.exs`:
```elixir
def deps do
  [{:kerosene, "~> 0.10.0"}]
end
```

Add Kerosene to your `repo.ex`:
```elixir
defmodule MyApp.Repo do
  use Ecto.Repo,
    otp_app: :my_app,
    adapter: Ecto.Adapters.Postgres
  use Kerosene, per_page: 2
end
```

## Usage
Start paginating your queries
```elixir
def index(conn, params) do
  {products, kerosene} =
  Product
  |> Product.with_lowest_price
  |> Repo.paginate(params)

  render(conn, "index.html", products: products, kerosene: kerosene)
end
```

Add view helpers to your view
```elixir
defmodule MyApp.ProductView do
  use MyApp.Web, :view
  import Kerosene.HTML
end
```

Generate the links using the view helpers
```elixir
<%= paginate @conn, @kerosene %>
```

Kerosene provides a [list](https://hexdocs.pm/kerosene/Kerosene.HTML.html#__using__/1) of themes for pagination. By default it uses bootstrap. To use some other, add to config/config.exs:
```elixir
config :kerosene,
	theme: :foundation
```

If you need reduced number of links in pagination, you can use `simple mode` option, to display only Prev/Next links:
```elixir
config :kerosene,
	mode:  :simple
```

Building apis or SPA's, no problem Kerosene has support for Json.

```elixir
defmodule MyApp.ProductView do
  use MyApp.Web, :view
  import Kerosene.JSON

  def render("index.json", %{products: products, kerosene: kerosene, conn: conn}) do
    %{data: render_many(products, MyApp.ProductView, "product.json"),
      pagination: paginate(conn, kerosene)}
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      name: product.name,
      description: product.description,
      price: product.price}
  end
end
```


You can also send in options to paginate helper look at the docs for more details.

## Contributing

Please do send pull requests and bug reports, positive feedback is always welcome.


## Acknowledgement

I would like to Thank

* Matt (@mgwidmann)
* Drew Olson (@drewolson)
* Akira Matsuda (@amatsuda)

## License

Please take a look at LICENSE.md
