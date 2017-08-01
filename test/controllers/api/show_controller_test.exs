defmodule Adze.API.ShowControllerTest do
  use Adze.ConnCase

  alias Adze.API.Show
  @valid_attrs %{name: "some content", network: "some content", notes: "some content", rate: "some content", recording_day: "some content", structure: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_show_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    show = Repo.insert! %Show{}
    conn = get conn, api_show_path(conn, :show, show)
    assert json_response(conn, 200)["data"] == %{"id" => show.id,
      "structure" => show.structure,
      "network" => show.network,
      "name" => show.name,
      "rate" => show.rate,
      "notes" => show.notes,
      "recording_day" => show.recording_day}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_show_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_show_path(conn, :create), show: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Show, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_show_path(conn, :create), show: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    show = Repo.insert! %Show{}
    conn = put conn, api_show_path(conn, :update, show), show: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Show, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    show = Repo.insert! %Show{}
    conn = put conn, api_show_path(conn, :update, show), show: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    show = Repo.insert! %Show{}
    conn = delete conn, api_show_path(conn, :delete, show)
    assert response(conn, 204)
    refute Repo.get(Show, show.id)
  end
end
