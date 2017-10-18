defmodule Jingle.API.Creative do
  use Jingle.Web, :model

  schema "creatives" do
    field :status, :string
    field :filename, :string
    field :zone, :string
    field :size, :integer
    field :content_type, :string
    field :label, :string
    field :length, :integer
    field :layer, :integer
    field :bit_rate, :integer
    field :duration, :integer
    field :channel_mode, :string
    field :upload_path, :string
    field :format, :string

    belongs_to :campaign, Jingle.API.Campaign
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:status, :filename, :zone, :size, :content_type, :label, :length, :layer, :bit_rate, :duration, :channel_mode, :upload_path, :format])
    |> validate_required([:status, :filename, :zone, :size, :content_type, :label, :length, :layer, :bit_rate, :duration, :channel_mode, :upload_path, :format])
  end
end
