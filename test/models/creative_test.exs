defmodule Jingle.CreativeTest do
  use Jingle.ModelCase

  alias Jingle.API.Creative

  @valid_attrs %{bit_rate: 42, campaign_id: 42, channel_mode: "some content", content_type: "some content", duration: 42, filename: "some content", format: "some content", label: "some content", layer: 42, length: 42, size: 42, status: "some content", upload_path: "some content", zone: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Creative.changeset(%Creative{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Creative.changeset(%Creative{}, @invalid_attrs)
    refute changeset.valid?
  end
end
