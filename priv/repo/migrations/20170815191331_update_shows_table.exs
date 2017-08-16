defmodule Adze.Repo.Migrations.UpdateShowsTable do
  use Ecto.Migration

  def change do
    alter table(:shows) do
      add :feeder_podcast_id, :integer
      add :adzerk_site_id, :integer
    end

    alter table(:sponsors) do
      add :adzerk_advertiser_id, :integer
    end

    alter table(:campaigns) do
      remove :repeat_sponsor
    end
  end
end
