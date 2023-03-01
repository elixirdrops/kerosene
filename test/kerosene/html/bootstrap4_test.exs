defmodule Kerosene.HTML.Bootstrap4Test do
  use ExUnit.Case, async: true
  use Phoenix.HTML

  alias Kerosene.HTML.Bootstrap4

  test "renders Bootstrap 4 pagination markup" do
    page_list = PaginatorData.page_list()

    valid_html_markup = """
    <nav>\
    <ul class="pagination">\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=1">First</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=6">&lt;</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=2">2</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=3">3</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=4">4</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=5">5</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=6">6</a></li>\
    <li class="page-item active"><a class="page-link" href="/products?category=25&amp;page=7">7</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=8">8</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=9">9</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=10">10</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=11">11</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=12">12</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=8">&gt;</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=16">Last</a></li>\
    </ul>\
    </nav>\
    """

    safe_html_tree = Bootstrap4.generate_links(page_list, nil)
    rendered_pagination = Phoenix.HTML.safe_to_string(safe_html_tree)

    assert rendered_pagination == valid_html_markup
  end

  test "renders Bootstrap 4 pagination markup with additional class" do
    page_list = PaginatorData.page_list()

    valid_html_markup = """
    <nav>\
    <ul class="pagination pagination-sm">\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=1">First</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=6">&lt;</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=2">2</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=3">3</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=4">4</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=5">5</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=6">6</a></li>\
    <li class="page-item active"><a class="page-link" href="/products?category=25&amp;page=7">7</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=8">8</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=9">9</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=10">10</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=11">11</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=12">12</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=8">&gt;</a></li>\
    <li class="page-item"><a class="page-link" href="/products?category=25&amp;page=16">Last</a></li>\
    </ul>\
    </nav>\
    """

    safe_html_tree = Bootstrap4.generate_links(page_list, "pagination-sm")
    rendered_pagination = Phoenix.HTML.safe_to_string(safe_html_tree)

    assert rendered_pagination == valid_html_markup
  end
end
