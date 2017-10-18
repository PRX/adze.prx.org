defmodule Castle.API.RootControllerTest do
  use Jingle.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists version and available paths", %{conn: conn} do
    conn = get conn, api_root_path(conn, :index)
    resp = json_response(conn, 200)
    assert resp["version"] == "v1"
    assert resp["_links"]["prx:sponsors"]
    assert resp["_links"]["prx:campaigns"]
    assert resp["_links"]["prx:shows"]
    assert resp["_links"]["prx:creatives"]
  end
end
