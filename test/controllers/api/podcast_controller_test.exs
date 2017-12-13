defmodule Jingle.API.PodcastControllerTest do
  use Jingle.ConnCase

  alias Jingle.Podcast
  @valid_attrs %{name: "some content", network: "some content", notes: "some content", rate: "some content", recording_day: "some content", structure: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_podcast_path(conn, :index)
    assert json_response(conn, 200)["_embedded"]["prx:items"]
    assert json_response(conn, 200)["count"]
  end

  test "shows chosen resource", %{conn: conn} do
    podcast = Repo.insert! %Podcast{}
    conn = get conn, api_podcast_path(conn, :show, podcast)
    assert json_response(conn, 200)["id"] == podcast.id
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_podcast_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_podcast_path(conn, :create), podcast: @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Podcast, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_podcast_path(conn, :create), podcast: @invalid_attrs
    assert json_response(conn, 400)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    podcast = Repo.insert! %Podcast{}
    conn = put conn, api_podcast_path(conn, :update, podcast), podcast: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Podcast, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    podcast = Repo.insert! %Podcast{}
    conn = put conn, api_podcast_path(conn, :update, podcast), podcast: @invalid_attrs
    assert json_response(conn, 400)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    podcast = Repo.insert! %Podcast{}
    conn = delete conn, api_podcast_path(conn, :delete, podcast)
    assert response(conn, 204)
    refute Repo.get(Podcast, podcast.id)
  end
end
