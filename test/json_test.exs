defmodule Kerosene.JSONTest do
  use ExUnit.Case, async: true

  test "renders a list of links in json format" do
    expected = [
      %{label: "First", url: "/products?category=25&page=1", page: 1, current: false},
      %{label: "<", url: "/products?category=25&page=6", page: 6, current: false},
      %{label: "2", url: "/products?category=25&page=2", page: 2, current: false},
      %{label: "3", url: "/products?category=25&page=3", page: 3, current: false},
      %{label: "4", url: "/products?category=25&page=4", page: 4, current: false},
      %{label: "5", url: "/products?category=25&page=5", page: 5, current: false},
      %{label: "6", url: "/products?category=25&page=6", page: 6, current: false},
      %{label: "7", url: "/products?category=25&page=7", page: 7, current: true},
      %{label: "8", url: "/products?category=25&page=8", page: 8, current: false},
      %{label: "9", url: "/products?category=25&page=9", page: 9, current: false},
      %{label: "10", url: "/products?category=25&page=10", page: 10, current: false},
      %{label: "11", url: "/products?category=25&page=11", page: 11, current: false},
      %{label: "12", url: "/products?category=25&page=12", page: 12, current: false},
      %{label: ">", url: "/products?category=25&page=8", page: 8, current: false},
      %{label: "Last", url: "/products?category=25&page=16", page: 16, current: false}
    ]

    data = PaginatorData.page_list()
    output = Kerosene.JSON.render_page_list(data)

    assert expected == output
  end
end
