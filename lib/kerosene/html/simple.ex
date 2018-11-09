defmodule Kerosene.HTML.Simple do
  use Phoenix.HTML

  def generate_links(page_list, additional_class) do
    content_tag :nav, class: build_html_class(additional_class) do
      for {label, _page, url, current} <- page_list do
        link("#{label}", to: url, class: build_html_class(current))
      end
    end
  end

  defp build_html_class(true), do: "active"
  defp build_html_class(false), do: nil

  defp build_html_class(additional_class) do
    String.trim("pagination #{additional_class}")
  end
end
