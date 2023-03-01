defmodule Kerosene.PaginatorTest do
  use ExUnit.Case, async: true
  import Kerosene.Paginator

  test "next page only if there are more pages" do
    assert next_page([], 10, 10) == []
    assert next_page([{:previous, 9}], 10, 10) == [{:previous, 9}]
    assert next_page([], 10, 12) == [{:next, 11}]
  end

  test "generate previous page unless first" do
    assert previous_page(0) == []
    assert previous_page(10) == [{:previous, 9}]
  end

  test "generate first page" do
    assert first_page([], 5, 3, true) == [{:first, 1}]
    assert first_page([], 5, 3, false) == []
    assert first_page([], 3, 3, true) == []
  end

  test "generate last page" do
    assert last_page([], 5, 10, 3, true) == [{:last, 10}]
    assert last_page([], 5, 10, 3, false) == []
    assert last_page([], 5, 10, 3, false) == []
  end

  test "encode query params" do
    params = [query: "foo", page: 2, per_page: 10]
    expected = "query=foo&page=2&per_page=10"
    assert build_query(params) == expected
  end

  test "build full abs url with params" do
    params = [query: "foo", page: 2, per_page: 10, foo: [1, 2]]
    conn = %{request_path: "http://localhost:4000/products"}
    expected = "http://localhost:4000/products?query=foo&page=2&per_page=10&foo[]=1&foo[]=2"
    assert build_url(conn, params) == expected
  end

  test "build full abs url with invalid params" do
    params = nil
    conn = %{request_path: "http://localhost:4000/products"}
    expected = "http://localhost:4000/products"
    assert build_url(conn, params) == expected
  end
end
