defmodule Adze.API.Campaign do
  use Adze.Web, :model

  schema "campaigns" do
    field :show_id, :integer
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date
    field :copy, :string
    field :zone, :string
    field :repeat_sponsor, :boolean, default: false

    belongs_to :sponsor, Adze.API.Sponsor
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:sponsor_id, :show_id, :start_date, :end_date, :copy, :zone, :repeat_sponsor])
    |> validate_required([:sponsor_id, :show_id, :start_date, :end_date, :copy, :zone, :repeat_sponsor])
    |> assoc_constraint(:sponsor)
  end
end
