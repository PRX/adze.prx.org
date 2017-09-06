defmodule Jingle.Repo.Migrations.CreateApi.Campaign do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :sponsor_id, :integer
      add :show_id, :integer
      add :start_date, :date
      add :end_date, :date
      add :copy, :text
      add :zone, :string
      add :repeat_sponsor, :boolean, default: false, null: false

      timestamps()
    end

  end
end
