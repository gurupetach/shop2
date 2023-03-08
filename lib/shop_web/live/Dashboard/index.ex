defmodule ShopWeb.DashboardLive.Index do
  @moduledoc """
  Landing page and product selection
  """

  use ShopWeb, :live_view
  import ShopWeb.LiveHelpers

  alias Shop.{Repo, Products}

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:selected_items, [])
      |> assign(:price, 0)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket =
      socket
      |> assign(:products, Products.list_products())
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "Add Product")
  end

  @impl true
  def handle_event("add", %{"id" => id}, socket) do
    product = Products.get_selected_product_query!(id) |> Repo.one()

    selected_items = socket.assigns.selected_items ++ [product]
    price = socket.assigns.price + product.price

    socket =
      socket
      |> assign(:selected_items, selected_items)
      |> assign(:price, price)

    {:noreply, assign(socket, :selected_items, selected_items)}
  end
end
