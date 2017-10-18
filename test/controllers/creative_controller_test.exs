defmodule Jingle.CreativeControllerTest do
  use Jingle.ConnCase

  alias Jingle.Creative
  @valid_attrs %{bit_rate: 42, channel_mode: "some content", content_type: "some content", duration: 42, filename: "some content", format: "some content", label: "some content", layer: 42, length: 42, size: 42, status: "some content", upload_path: "some content", zone: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, creative_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    creative = Repo.insert! %Creative{}
    conn = get conn, creative_path(conn, :show, creative)
    assert json_response(conn, 200)["data"] == %{"id" => creative.id,
      "status" => creative.status,
      "filename" => creative.filename,
      "zone" => creative.zone,
      "size" => creative.size,
      "content_type" => creative.content_type,
      "label" => creative.label,
      "length" => creative.length,
      "layer" => creative.layer,
      "bit_rate" => creative.bit_rate,
      "duration" => creative.duration,
      "channel_mode" => creative.channel_mode,
      "upload_path" => creative.upload_path,
      "format" => creative.format}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, creative_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, creative_path(conn, :create), creative: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Creative, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, creative_path(conn, :create), creative: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    creative = Repo.insert! %Creative{}
    conn = put conn, creative_path(conn, :update, creative), creative: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Creative, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    creative = Repo.insert! %Creative{}
    conn = put conn, creative_path(conn, :update, creative), creative: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    creative = Repo.insert! %Creative{}
    conn = delete conn, creative_path(conn, :delete, creative)
    assert response(conn, 204)
    refute Repo.get(Creative, creative.id)
  end
end
