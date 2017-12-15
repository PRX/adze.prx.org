defmodule Jingle.Creative do
  use Jingle.Web, :model

  schema "creatives" do
    field :status, :string
    field :filename, :string
    field :zone, :string
    field :size, :integer
    field :content_type, :string
    field :label, :string
    field :length, :decimal
    field :layer, :integer
    field :bit_rate, :integer
    field :channel_mode, :string
    field :upload_path, :string
    field :format, :string

    belongs_to :campaign, Jingle.Campaign
    timestamps(type: :utc_datetime)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:campaign_id, :status, :filename, :zone, :size, :content_type, :label, :length, :layer, :bit_rate, :channel_mode, :upload_path, :format])
    |> validate_required([:campaign_id, :status, :filename, :zone, :size, :content_type, :label, :length, :layer, :bit_rate, :channel_mode, :upload_path, :format])
    |> assoc_constraint(:campaign)
  end
end
