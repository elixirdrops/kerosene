defmodule Kerosene.Paginator do
  use Phoenix.HTML

  @default [window: 3, range: true, next_label: "Next", previous_label: "Previous", first: true, first_label: "First", last: true, last_label: "Last"]

  @moduledoc """
  Helpers to render the pagination links and more.
  """

  @doc false
  def paginate(conn, paginator, opts \\ []) do
    page = paginator.page
    total_pages = paginator.total_pages
    params = build_params(paginator.params, opts[:params])

    page
    |> previous_page
    |> first_page(page, opts[:window], opts[:first])
    |> page_list(page, total_pages, opts[:window], opts[:range])
    |> next_page(page, total_pages)
    |> last_page(page, total_pages, opts[:window], opts[:last])
    |> Enum.map(fn {l, p} -> 
     {label_text(l, opts), p, build_url(conn, Map.put(params, "page", p)), page == p} 
    end)
  end

  def label_text(label, opts) do
    case label do
      :first    -> opts[:first_label]
      :previous -> opts[:previous_label]
      :next     -> opts[:next_label]
      :last     -> opts[:last_label]
      _         -> label
    end
  end

  @doc """
  Generates a page list based on current window
  """
  def page_list(list, page, total, window, true) when is_integer(window) and window >= 1 do
    page_list = left(page, total, window)..right(page, total, window) 
    |> Enum.map(fn n -> {n, n} end)

    list ++ page_list
  end
  def page_list(list, _page, _total, _window, _range), do: list

  def left(page, _total, window) when page - window <= 1 do
    1
  end
  def left(page, _total, window), do: page - window

  def right(page, total, window) when page + window >= total do
    total
  end
  def right(page, _total, window), do: page + window

  def previous_page(page) when page > 1 do
    [{:previous, page - 1}]
  end
  def previous_page(_page), do: []

  def next_page(list, page, total) when page < total do
    list ++ [{:next, page + 1}]
  end
  def next_page(list, _page, _total), do: list

  def first_page(list, page, window, true) when page - window > 1 do
    [{:first, 1} | list]
  end
  def first_page(list, _page, _window, _included), do: list

  def last_page(list, page, total, window, true) when page + window < total do
    list ++ [{:last, total}]
  end
  def last_page(list, _page, _total, _window, _included), do: list

  def build_url(conn, nil), do: conn.request_path
  def build_url(conn, params) do
    "#{conn.request_path}?#{build_query(params)}"
  end

  @doc """
  Constructs a query param from a keyword list
  """
  def build_query(params) do
    params |> Plug.Conn.Query.encode
  end

  def build_params(params, params2) do
    Map.merge(params, params2) |> normalize_keys()
  end

  def normalize_keys(params) when is_map(params) do
    for {key, val} <- params, into: %{}, do: {to_string(key), val}
  end
  def normalize_keys(params), do: params

  def build_options(opts) do
    params = opts[:params] || %{}
    theme  = opts[:theme]  || Application.get_env(:kerosene, :theme, :bootstrap)
    opts   = Keyword.merge(opts, [params: params, theme: theme])

    Keyword.merge(@default, opts)
  end
end
