defmodule Jingle.PageControllerTest do
  use Jingle.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 302) =~ "redirect"
  end
end
