defmodule Jingle.CreativeControllerTest do
  use Jingle.ConnCase

  alias Jingle.API.Creative
  @valid_attrs %{bit_rate: 42, campaign_id: 42, channel_mode: "some content", content_type: "some content", filename: "some content", format: "some content", label: "some content", layer: 42, length: 42, size: 42, status: "some content", upload_path: "some content", zone: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_creative_path(conn, :index)
    assert json_response(conn, 200)["_embedded"]["prx:items"]
    assert json_response(conn, 200)["count"]
  end

  test "shows chosen resource", %{conn: conn} do
    creative = Repo.insert! %Creative{campaign_id: 42}
    conn = get conn, api_creative_path(conn, :show, creative)
    resp = json_response(conn, 200)
    assert resp["id"] == creative.id
    assert resp["status"] == creative.status
    assert resp["filename"] == creative.filename
    assert resp["zone"] == creative.zone
    assert resp["size"] == creative.size
    assert resp["content_type"] == creative.content_type
    assert resp["label"] == creative.label
    assert resp["length"] == creative.length
    assert resp["layer"] == creative.layer
    assert resp["bit_rate"] == creative.bit_rate
    assert resp["channel_mode"] == creative.channel_mode
    assert resp["upload_path"] == creative.upload_path
    assert resp["format"] == creative.format
    assert resp["_links"]["prx:campaign"]
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_creative_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_creative_path(conn, :create), creative: @valid_attrs
    assert json_response(conn, 201)["label"]
    assert json_response(conn, 201)["_links"]
    assert Repo.get_by(Creative, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_creative_path(conn, :create), creative: @invalid_attrs
    assert json_response(conn, 400)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    creative = Repo.insert! %Creative{}
    conn = put conn, api_creative_path(conn, :update, creative), creative: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Creative, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    creative = Repo.insert! %Creative{}
    conn = put conn, api_creative_path(conn, :update, creative), creative: @invalid_attrs
    assert json_response(conn, 400)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    creative = Repo.insert! %Creative{}
    conn = delete conn, api_creative_path(conn, :delete, creative)
    assert response(conn, 204)
    refute Repo.get(Creative, creative.id)
  end
end
