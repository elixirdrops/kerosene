defmodule Kerosene.JSON do
  use Phoenix.HTML
  import Kerosene.Paginator, only: [build_options: 1]

  @moduledoc """
  JSON helpers to render the pagination links in json format.
  import the `Kerosene.JSON` in your view module.

      defmodule MyApp.ProductView do
        use MyApp.Web, :view
        import Kerosene.JSON

        def render("index.json", %{conn: conn, products: products, kerosene: kerosene}) do
          %{data: render_many(products, MyApp.ProductView, "product.json"),
            pagination: paginate(conn, kerosene)}
        end
      end


  Where `kerosene` is a `%Kerosene{}` struct returned from `Repo.paginate/2`.

  `paginate` helper takes keyword list of `options`.
    paginate(kerosene, window: 5, next_label: ">>", previous_label: "<<", first: true, last: true, first_label: "First", last_label: "Last")
  """
  defmacro __using__(_opts \\ []) do
    quote do
      import Kerosene.JSON
    end
  end

  def paginate(conn, paginator, opts \\ []) do
    opts = build_options(opts)

    Kerosene.Paginator.paginate(conn, paginator, opts)
    |> render_page_list()
  end

  def render_page_list(page_list) do
    Enum.map(page_list, fn {link_label, page, url, current} ->
      %{label: "#{link_label}", url: url, page: page, current: current}
    end)
  end
end
