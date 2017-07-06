defmodule Adze.API.Sponsor do
  use Adze.Web, :model

  schema "sponsors" do
    field :name, :string
    field :billing_info, :string
    field :notes, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :billing_info, :notes])
    |> validate_required([:name, :billing_info, :notes])
  end
end
