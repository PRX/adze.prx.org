defmodule Jingle.API.PodcastTest do
  use Jingle.ModelCase

  alias Jingle.API.Podcast

  @valid_attrs %{name: "some content", network: "some content", notes: "some content", rate: "some content", recording_day: "some content", structure: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Podcast.changeset(%Podcast{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Podcast.changeset(%Podcast{}, @invalid_attrs)
    refute changeset.valid?
  end
end
