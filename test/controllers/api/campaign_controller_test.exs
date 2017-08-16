defmodule Adze.API.CampaignControllerTest do
  use Adze.ConnCase

  alias Adze.API.Campaign
  @valid_attrs %{copy: "some content", end_date: %{day: 17, month: 4, year: 2010}, show_id: 42, sponsor_id: 42, start_date: %{day: 17, month: 4, year: 2010}, zone: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_campaign_path(conn, :index)
    assert json_response(conn, 200) == %{
      "_embedded" => %{
        "prx:items" => []
      },
      "count" => 0,
      "total" => 0
    }
  end

  test "shows chosen resource", %{conn: conn} do
    campaign = Repo.insert! %Campaign{show_id: 42, sponsor_id: 42}
    conn = get conn, api_campaign_path(conn, :show, campaign)
    assert json_response(conn, 200)["id"] == campaign.id
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_campaign_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_campaign_path(conn, :create), campaign: @valid_attrs
    assert json_response(conn, 201)["id"]
    assert Repo.get_by(Campaign, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_campaign_path(conn, :create), campaign: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    campaign = Repo.insert! %Campaign{}
    conn = put conn, api_campaign_path(conn, :update, campaign), campaign: @valid_attrs
    assert json_response(conn, 200)["id"]
    assert Repo.get_by(Campaign, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    campaign = Repo.insert! %Campaign{}
    conn = put conn, api_campaign_path(conn, :update, campaign), campaign: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    campaign = Repo.insert! %Campaign{}
    conn = delete conn, api_campaign_path(conn, :delete, campaign)
    assert response(conn, 204)
    refute Repo.get(Campaign, campaign.id)
  end
end
