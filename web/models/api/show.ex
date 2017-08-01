defmodule Adze.API.Show do
  use Adze.Web, :model

  schema "shows" do
    field :structure, :string
    field :network, :string
    field :name, :string
    field :rate, :string
    field :notes, :string
    field :recording_day, :string

    has_many :campaigns, Adze.API.Campaign
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:structure, :network, :name, :rate, :notes, :recording_day])
    |> validate_required([:structure, :network, :name, :rate, :notes, :recording_day])
  end
end
