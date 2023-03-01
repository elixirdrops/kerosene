defmodule Kerosene.HTML.FoundationTest do
  use ExUnit.Case, async: true
  use Phoenix.HTML

  alias Kerosene.HTML.Foundation

  test "renders Foundation pagination markup" do
    page_list = PaginatorData.page_list()

    valid_html_markup = """
    <ul class="pagination" role="pagination">\
    <li><a href="/products?category=25&amp;page=1">First</a></li>\
    <li><a href="/products?category=25&amp;page=6">&lt;</a></li>\
    <li><a href="/products?category=25&amp;page=2">2</a></li>\
    <li><a href="/products?category=25&amp;page=3">3</a></li>\
    <li><a href="/products?category=25&amp;page=4">4</a></li>\
    <li><a href="/products?category=25&amp;page=5">5</a></li>\
    <li><a href="/products?category=25&amp;page=6">6</a></li>\
    <li class="active"><a href="/products?category=25&amp;page=7">7</a></li>\
    <li><a href="/products?category=25&amp;page=8">8</a></li>\
    <li><a href="/products?category=25&amp;page=9">9</a></li>\
    <li><a href="/products?category=25&amp;page=10">10</a></li>\
    <li><a href="/products?category=25&amp;page=11">11</a></li>\
    <li><a href="/products?category=25&amp;page=12">12</a></li>\
    <li><a href="/products?category=25&amp;page=8">&gt;</a></li>\
    <li><a href="/products?category=25&amp;page=16">Last</a></li>\
    </ul>\
    """

    safe_html_tree = Foundation.generate_links(page_list, nil)
    rendered_pagination = Phoenix.HTML.safe_to_string(safe_html_tree)

    assert rendered_pagination == valid_html_markup
  end

  test "renders Foundation pagination markup with additional class" do
    page_list = PaginatorData.page_list()

    valid_html_markup = """
    <ul class="pagination custom-class" role="pagination">\
    <li><a href="/products?category=25&amp;page=1">First</a></li>\
    <li><a href="/products?category=25&amp;page=6">&lt;</a></li>\
    <li><a href="/products?category=25&amp;page=2">2</a></li>\
    <li><a href="/products?category=25&amp;page=3">3</a></li>\
    <li><a href="/products?category=25&amp;page=4">4</a></li>\
    <li><a href="/products?category=25&amp;page=5">5</a></li>\
    <li><a href="/products?category=25&amp;page=6">6</a></li>\
    <li class="active"><a href="/products?category=25&amp;page=7">7</a></li>\
    <li><a href="/products?category=25&amp;page=8">8</a></li>\
    <li><a href="/products?category=25&amp;page=9">9</a></li>\
    <li><a href="/products?category=25&amp;page=10">10</a></li>\
    <li><a href="/products?category=25&amp;page=11">11</a></li>\
    <li><a href="/products?category=25&amp;page=12">12</a></li>\
    <li><a href="/products?category=25&amp;page=8">&gt;</a></li>\
    <li><a href="/products?category=25&amp;page=16">Last</a></li>\
    </ul>\
    """

    safe_html_tree = Foundation.generate_links(page_list, "custom-class")
    rendered_pagination = Phoenix.HTML.safe_to_string(safe_html_tree)

    assert rendered_pagination == valid_html_markup
  end
end
