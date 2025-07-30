defmodule TestappWeb.TodoHTML do
  use TestappWeb, :html

  def index(assigns) do
    ~H"""
    <h1>To Dos</h1>
    """
  end

  def show(assigns) do
    ~H"""
    <.display_secret_access secret_access={@secret_access} />
    <h1 class="font-bold">This is To Do #{@todo_id}</h1>
    """
  end

  # ? components
  def display_secret_access(assigns) do
    ~H"""
    <%= if assigns.secret_access do %>
      <h1>Secret access granted ✅</h1>
    <% else %>
      <h1>Secret access not granted ⛔</h1>
    <% end %>
    """
  end
end
