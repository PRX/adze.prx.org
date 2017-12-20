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
    params = atomize_map(params)
    date_params = Map.take(params, [:start_date, :end_date, :due_date])
    parsed_date_params = for { k, v } <- date_params, into: %{}, do: { k, parse_dtim(v) }
    Map.merge(params, parsed_date_params)
  end

  defp atomize_map(map) do
    atomize = fn(val) -> if is_binary(val), do: String.to_atom(val), else: val end
    for { key, val } <- map, into: %{}, do: { atomize.(key), val }
  end

  defp parse_dtim(date_str) do
    case Timex.parse(date_str, "{YYYY}-{0M}-{0D}") do
      {:ok, dtim} -> Timex.Timezone.convert(dtim, :utc)
      {:error, _} -> date_str
    end
  end
end
