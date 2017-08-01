defmodule Adze.API.ShowTest do
  use Adze.ModelCase

  alias Adze.API.Show

  @valid_attrs %{name: "some content", network: "some content", notes: "some content", rate: "some content", recording_day: "some content", structure: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Show.changeset(%Show{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Show.changeset(%Show{}, @invalid_attrs)
    refute changeset.valid?
  end
end
