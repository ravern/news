defmodule NewsSearchWeb.SearchControllerTest do
  use NewsSearchWeb.ConnCase

  test "GET / shows form", %{conn: conn} do
    conn = get conn, "/"
    response = html_response(conn, 200)
    assert response =~ "SG News Search"
    assert response =~ "Search"
  end

  test "GET /search shows form", %{conn: conn} do
    conn = get conn, "/"
    response = html_response(conn, 200)
    assert response =~ "SG News Search"
    assert response =~ "Search"
  end
end
