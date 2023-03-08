defmodule ShopWeb.DashboardLive.Index do
  @moduledoc """
  Landing page and product selection
  """

  use ShopWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
