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
    date_format = "{YYYY}-{0M}-{0D}"
    params_list = for { k, v } <- params, do: { atomize_binary(k), v }
    atomized_params = Map.new(params_list)

    try do
      %{ atomized_params | start_date: Timex.parse!(atomized_params[:start_date], date_format),
                        end_date: Timex.parse!(atomized_params[:end_date], date_format),
                        due_date: Timex.parse!(atomized_params[:due_date], date_format) }

    rescue
      # if we errored out on parsing, yield params as they are
      FunctionClauseError -> params
    end
  end

  defp atomize_binary(value) do
    if is_binary(value), do: String.to_atom(value), else: value
  end
end
