defmodule TestappWeb.TodoController do
  use TestappWeb, :controller

  def index(conn, _assigns) do
    render(conn, :index)
  end

  def show(conn, %{"todo_id" => todo_id}) do
    dbg(todo_id)
    render(conn, :show, todo_id: todo_id)
  end
end
