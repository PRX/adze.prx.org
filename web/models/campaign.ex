defmodule Jingle.Campaign do
  use Jingle.Web, :model

  schema "campaigns" do
    field :start_date, :datetime
    field :end_date, :datetime
    field :due_date, :utc_datetime
    field :original_copy, :string
    field :edited_copy, :string
    field :must_say, :string
    field :notes, :string
    field :approved, :boolean
    field :zone, :string

    belongs_to :sponsor, Jingle.Sponsor
    belongs_to :podcast, Jingle.Podcast
    has_many :creatives, Jingle.Creative
    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:sponsor_id, :podcast_id, :start_date, :end_date, :due_date, :original_copy, :edited_copy, :must_say, :notes, :approved, :zone])
    |> validate_required([:start_date, :end_date, :original_copy, :zone])
    |> assoc_constraint(:sponsor)
    |> assoc_constraint(:podcast)
  end
end
