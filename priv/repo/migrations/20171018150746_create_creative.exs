defmodule Jingle.Repo.Migrations.CreateCreative do
  use Ecto.Migration

  def change do
    create table(:creatives) do
      add :campaign_id, :integer
      add :status, :string
      add :filename, :string
      add :zone, :string
      add :size, :integer
      add :content_type, :string
      add :label, :string
      add :length, :integer
      add :layer, :integer
      add :bit_rate, :integer
      add :duration, :integer
      add :channel_mode, :string
      add :upload_path, :string
      add :format, :string

      timestamps()
    end

  end
end
