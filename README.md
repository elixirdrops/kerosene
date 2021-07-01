# Kerosene

[![Module Version](https://img.shields.io/hexpm/v/kerosene.svg)](https://hex.pm/packages/kerosene)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/kerosene/)
[![Total Download](https://img.shields.io/hexpm/dt/kerosene.svg)](https://hex.pm/packages/kerosene)
[![License](https://img.shields.io/hexpm/l/kerosene.svg)](https://github.com/elixirdrops/kerosene/blob/master/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/elixirdrops/kerosene.svg)](https://github.com/elixirdrops/kerosene/commits/master)

Pagination for Ecto and Phoenix.


## Installation

The package is [available in Hex](https://hex.pm/packages/kerosene), the package can be installed as:

Add `:kerosene` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:kerosene, "~> 0.9.0"}
  ]
end
```

Add `:kerosene` to your `repo.ex`:

```elixir
defmodule MyApp.Repo do
  use Ecto.Repo,
    otp_app: :testapp,
    adapter: Ecto.Adapters.Postgres
  use Kerosene, per_page: 2
end
```

## Usage

Start paginating your queries:

```elixir
def index(conn, params) do
  {products, kerosene} =
  Product
  |> Product.with_lowest_price
  |> Repo.paginate(params)

  render(conn, "index.html", products: products, kerosene: kerosene)
end
```

Add view helpers to your view:

```elixir
defmodule MyApp.ProductView do
  use MyApp.Web, :view
  import Kerosene.HTML
end
```

Generate the links using the view helpers:

```elixir
<%= paginate @conn, @kerosene %>
```

Kerosene provides a [list ](https://hexdocs.pm/kerosene/Kerosene.HTML.html#__using__/1) of themes for pagination. By default it uses bootstrap. To use some other, add to `config/config.exs`:

```elixir
config :kerosene,
	theme: :foundation
```

If you need reduced number of links in pagination, you can use `simple mode` option, to display only Prev/Next links:

```elixir
config :kerosene,
	mode:  :simple
```

Building APIs or SPA's, no problem Kerosene has support for JSON.

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

## Acknowledgment

I would like to Thank

* Matt (@mgwidmann)
* Drew Olson (@drewolson)
* Akira Matsuda (@amatsuda)

## Copyright and License

Copyright (c) 2014 Ally Raza

Released under the MIT License, which can be found in the repository in
[LICENSE.md](./LICENSE.md).
