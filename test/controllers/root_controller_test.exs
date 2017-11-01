defmodule Jingle.RootControllerTest do
  use Jingle.ConnCase

  test "lists version and available paths", %{conn: conn} do
    conn = get conn, api_root_path(conn, :index)
    resp = json_response(conn, 200)
    assert resp["version"] == "v1"
    assert resp["_links"]["prx:sponsors"]
    assert resp["_links"]["prx:campaigns"]
    assert resp["_links"]["prx:podcasts"]
    assert resp["_links"]["prx:creatives"]
  end
end
