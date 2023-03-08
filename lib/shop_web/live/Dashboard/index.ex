defmodule ShopWeb.DashboardLive.Index do
  @moduledoc """
  Landing page and product selection
  """

  use ShopWeb, :live_view
  alias Shop.Products

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:products, Products.list_products())

    {:ok, socket}
  end
end
