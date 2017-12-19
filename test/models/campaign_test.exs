defmodule Jingle.CampaignTest do
  use Jingle.ModelCase

  alias Jingle.Campaign

  @valid_attrs %{
    original_copy: "content",
    zone: "content",
    podcast_id: 31,
    sponsor_id: 31,
    end_date: %{day: 17, month: 4, year: 2010, hour: 0, minute: 0},
    start_date: %{day: 17, month: 4, year: 2010, hour: 0, minute: 0},
    due_date: %{day: 17, month: 4, year: 2010, hour: 0, minute: 0}
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Campaign.changeset(%Campaign{}, @valid_attrs)
    assert changeset.valid?
  end

  test "handles various date input types" do
    required = %{ zone: "zone", original_copy: "copy", sponsor_id: 1, podcast_id: 1 }
    string_date_params = %{
      end_date: "2018-01-01",
      start_date: "2018-01-01",
      due_date: "2018-01-01"
    }
    changeset = Campaign.changeset(%Campaign{}, Map.merge(required, string_date_params))
    assert changeset.valid?
    assert changeset.changes.end_date.year == 2018

    map_date_params = %{
      start_date: %{day: 17, month: 4, year: 2017, hour: 0, minute: 0},
      end_date: %{day: 17, month: 4, year: 2019, hour: 0, minute: 0},
      due_date: %{day: 10, month: 4, year: 2017, hour: 0, minute: 0}
    }
    changeset = Campaign.changeset(%Campaign{}, Map.merge(required, map_date_params))
    assert changeset.valid?
    assert changeset.changes.end_date.year == 2019
    #
    tuple_date_params = %{
      start_date: %{day: 17, month: 4, year: 2017, hour: 0, minute: 0},
      end_date: %{day: 17, month: 4, year: 2020, hour: 0, minute: 0},
      due_date: %{day: 10, month: 4, year: 2017, hour: 0, minute: 0}
    }
    changeset = Campaign.changeset(%Campaign{}, Map.merge(required, tuple_date_params))
    assert changeset.valid?
    assert changeset.changes.end_date.year == 2020
  end

  test "changeset with invalid attributes" do
    changeset = Campaign.changeset(%Campaign{}, @invalid_attrs)
    refute changeset.valid?
  end
end
