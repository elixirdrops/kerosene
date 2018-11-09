defmodule Kerosene.HTML.SemanticTest do
  use ExUnit.Case, async: true
  use Phoenix.HTML

  alias Kerosene.HTML.Semantic

  test "renders Semantic pagination markup" do
    page_list = PaginatorData.page_list()

    valid_html_markup = """
    <nav class="ui pagination menu">\
    <a class="item" href="/products?category=25&amp;page=1">First</a>\
    <a class="item" href="/products?category=25&amp;page=6">&lt;</a>\
    <a class="item" href="/products?category=25&amp;page=2">2</a>\
    <a class="item" href="/products?category=25&amp;page=3">3</a>\
    <a class="item" href="/products?category=25&amp;page=4">4</a>\
    <a class="item" href="/products?category=25&amp;page=5">5</a>\
    <a class="item" href="/products?category=25&amp;page=6">6</a>\
    <a class="item active" href="/products?category=25&amp;page=7">7</a>\
    <a class="item" href="/products?category=25&amp;page=8">8</a>\
    <a class="item" href="/products?category=25&amp;page=9">9</a>\
    <a class="item" href="/products?category=25&amp;page=10">10</a>\
    <a class="item" href="/products?category=25&amp;page=11">11</a>\
    <a class="item" href="/products?category=25&amp;page=12">12</a>\
    <a class="item" href="/products?category=25&amp;page=8">&gt;</a>\
    <a class="item" href="/products?category=25&amp;page=16">Last</a>\
    </nav>\
    """

    safe_html_tree = Semantic.generate_links(page_list, nil)
    rendered_pagination = Phoenix.HTML.safe_to_string(safe_html_tree)

    assert rendered_pagination == valid_html_markup
  end

  test "renders Semantic pagination markup with additonal class" do
    page_list = PaginatorData.page_list()

    valid_html_markup = """
    <nav class="ui pagination menu custom-class">\
    <a class="item" href="/products?category=25&amp;page=1">First</a>\
    <a class="item" href="/products?category=25&amp;page=6">&lt;</a>\
    <a class="item" href="/products?category=25&amp;page=2">2</a>\
    <a class="item" href="/products?category=25&amp;page=3">3</a>\
    <a class="item" href="/products?category=25&amp;page=4">4</a>\
    <a class="item" href="/products?category=25&amp;page=5">5</a>\
    <a class="item" href="/products?category=25&amp;page=6">6</a>\
    <a class="item active" href="/products?category=25&amp;page=7">7</a>\
    <a class="item" href="/products?category=25&amp;page=8">8</a>\
    <a class="item" href="/products?category=25&amp;page=9">9</a>\
    <a class="item" href="/products?category=25&amp;page=10">10</a>\
    <a class="item" href="/products?category=25&amp;page=11">11</a>\
    <a class="item" href="/products?category=25&amp;page=12">12</a>\
    <a class="item" href="/products?category=25&amp;page=8">&gt;</a>\
    <a class="item" href="/products?category=25&amp;page=16">Last</a>\
    </nav>\
    """

    safe_html_tree = Semantic.generate_links(page_list, "custom-class")
    rendered_pagination = Phoenix.HTML.safe_to_string(safe_html_tree)

    assert rendered_pagination == valid_html_markup
  end
end
