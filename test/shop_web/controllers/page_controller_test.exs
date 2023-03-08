defmodule ShopWeb.PageControllerTest do
  use ShopWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Products"
  end
end
