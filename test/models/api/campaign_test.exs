defmodule Adze.API.CampaignTest do
  use Adze.ModelCase

  alias Adze.API.Campaign

  @valid_attrs %{copy: "some content", end_date: %{day: 17, month: 4, year: 2010}, repeat_sponsor: true, show_id: 42, sponsor_id: 42, start_date: %{day: 17, month: 4, year: 2010}, zone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Campaign.changeset(%Campaign{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Campaign.changeset(%Campaign{}, @invalid_attrs)
    refute changeset.valid?
  end
end
