defmodule Jingle.API.SponsorControllerTest do
  use Jingle.ConnCase

  alias Jingle.API.Sponsor
  @valid_attrs %{billing_info: "some content", name: "some content", notes: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_sponsor_path(conn, :index)
    assert json_response(conn, 200)["_embedded"]["prx:items"]
    assert json_response(conn, 200)["count"]
  end

  test "shows chosen resource", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = get conn, api_sponsor_path(conn, :show, sponsor)
    assert json_response(conn, 200)["name"] == sponsor.name
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_sponsor_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_sponsor_path(conn, :create), sponsor: @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Sponsor, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_sponsor_path(conn, :create), sponsor: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = put conn, api_sponsor_path(conn, :update, sponsor), sponsor: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Sponsor, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = put conn, api_sponsor_path(conn, :update, sponsor), sponsor: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    sponsor = Repo.insert! %Sponsor{}
    conn = delete conn, api_sponsor_path(conn, :delete, sponsor)
    assert response(conn, 204)
    refute Repo.get(Sponsor, sponsor.id)
  end
end
