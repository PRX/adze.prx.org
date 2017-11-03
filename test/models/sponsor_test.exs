defmodule Jingle.SponsorTest do
  use Jingle.ModelCase

  alias Jingle.Sponsor

  @valid_attrs %{billing_info: "some content", name: "some content", notes: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sponsor.changeset(%Sponsor{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sponsor.changeset(%Sponsor{}, @invalid_attrs)
    refute changeset.valid?
  end
end
