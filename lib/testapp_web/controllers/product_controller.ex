defmodule TestappWeb.ProductController do
  use TestappWeb, :controller

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end
end
