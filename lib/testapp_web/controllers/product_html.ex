defmodule TestappWeb.ProductHTML do
  use TestappWeb, :html

  embed_templates "product_html/*"

  # def index(assigns) do
  #   ~H"""
  #     <h1>this is product :index</h1>
  #   """
  # end
end
