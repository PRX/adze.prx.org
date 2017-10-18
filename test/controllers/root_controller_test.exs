defmodule Castle.API.RootControllerTest do
  use Jingle.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists version and available paths", %{conn: conn} do
    conn = get conn, api_root_path(conn, :index)
    assert json_response(conn, 200)["version"] == "v1"
  end
end
