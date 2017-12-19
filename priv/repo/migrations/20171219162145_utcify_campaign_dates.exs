defmodule Jingle.Repo.Migrations.UtcifyCampaignDates do
  use Ecto.Migration

  def change do
    alter table(:campaigns) do
      modify :start_date, :utc_datetime
      modify :end_date, :utc_datetime
    end
  end
end
