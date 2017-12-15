defmodule Jingle.CampaignTest do
  use Jingle.ModelCase

  alias Jingle.Campaign

  @valid_attrs %{original_copy: "some content", end_date: %{day: 17, month: 4, year: 2010}, podcast_id: 42, sponsor_id: 42, start_date: %{day: 17, month: 4, year: 2010}, due_date: %{day: 17, month: 4, year: 2010}, zone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Campaign.changeset(%Campaign{}, @valid_attrs)
    assert changeset.valid?
  end

  test "casts times to utc-convertable times without overwriting fields" do
    changeset = Campaign.changeset(%Campaign{}, @valid_attrs)
    assert changeset.valid?
    assert changeset.changes.due_date.hour == 0

    date_with_time = %{day: 17, month: 4, year: 2010, minute: 30, hour: 10}
    new_params = %{@valid_attrs | end_date: date_with_time}

    changeset = Campaign.changeset(%Campaign{}, new_params)
    assert changeset.valid?
    assert changeset.changes.end_date.hour == 10
    assert changeset.changes.end_date.minute == 30
  end

  test "changeset with invalid attributes" do
    changeset = Campaign.changeset(%Campaign{}, @invalid_attrs)
    refute changeset.valid?
  end
end
