defmodule ShopWeb.DashboardLiveTest do
  use ShopWeb.ConnCase

  import Phoenix.LiveViewTest
  import Shop.ProductsFixtures

  defp create_todo(_) do
    product = product_fixture()
    %{product: product}
  end

  describe "Index" do
    setup [:create_todo]

    test "lists all products", %{conn: conn, product: product} do
      {:ok, _index_live, html} = live(conn, Routes.dashboard_index_path(conn, :index))

      assert html =~ "Products"
      assert html =~ product.name
    end

    test "clicking PRODUCT + redirects page", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.dashboard_index_path(conn, :index))

      assert index_live |> element("a", "PRODUCT +") |> render_click()

      assert_redirect(index_live, Routes.dashboard_index_path(conn, :new))
    end
  end
end
