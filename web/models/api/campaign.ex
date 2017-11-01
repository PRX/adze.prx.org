defmodule Jingle.API.Campaign do
  use Jingle.Web, :model

  schema "campaigns" do
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date
    field :copy, :string
    field :zone, :string

    belongs_to :sponsor, Jingle.API.Sponsor
    belongs_to :podcast, Jingle.API.Podcast
    has_many :creatives, Jingle.API.Creative
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:sponsor_id, :podcast_id, :start_date, :end_date, :copy, :zone])
    |> validate_required([:sponsor_id, :podcast_id, :start_date, :end_date, :copy, :zone])
    |> assoc_constraint(:sponsor)
  end
end
