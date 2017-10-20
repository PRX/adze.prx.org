defmodule Jingle.RedirectControllerTest do
  use Jingle.ConnCase

  test "redirects to the api", %{conn: conn} do
    location = conn |> get(redirect_path(conn, :index)) |> redirected_to(302)
    assert location == "/api/v1"
  end
end
