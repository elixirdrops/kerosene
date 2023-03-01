defmodule Kerosene.HTML.Materialize do
  use Phoenix.HTML

  def generate_links(page_list, additional_class) do
    content_tag :ul, class: build_html_class(additional_class) do
      for {label, _page, url, current} <- page_list do
        content_tag :li, class: build_html_class(current) do
          link("#{label}", to: url)
        end
      end
    end
  end

  defp build_html_class(true), do: "active"
  defp build_html_class(false), do: "waves-effect"

  defp build_html_class(additional_class) do
    String.trim("pagination #{additional_class}")
  end
end
