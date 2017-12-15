defmodule Jingle.Campaign do
  use Jingle.Web, :model

  schema "campaigns" do
    field :start_date, :utc_datetime
    field :end_date, :utc_datetime
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
    |> cast(utc_compatible_dates(params), [:sponsor_id, :podcast_id, :start_date, :end_date, :due_date, :original_copy, :edited_copy, :must_say, :notes, :approved, :zone])
    |> validate_required([:start_date, :end_date, :due_date, :original_copy, :zone])
    |> assoc_constraint(:sponsor)
    |> assoc_constraint(:podcast)
  end

  defp utc_compatible_dates(params) do
    midnight = %{hour: 0, minute: 0}

    try do
      Map.update!(params, :start_date, &Map.merge(midnight, &1))
      |> Map.update!(:end_date, &Map.merge(midnight, &1))
      |> Map.update!(:due_date, &Map.merge(midnight, &1))
    rescue
      # if one of these is missing, let the requirement validation catch it
      KeyError -> params
    end
  end
end
