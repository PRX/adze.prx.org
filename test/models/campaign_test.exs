defmodule Jingle.CampaignTest do
  use Jingle.ModelCase

  alias Jingle.Campaign

  @valid_attrs %{original_copy: "some content", end_date: %{day: 17, month: 4, year: 2010}, podcast_id: 42, sponsor_id: 42, start_date: %{day: 17, month: 4, year: 2010}, zone: "some content"}
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
