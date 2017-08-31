defmodule Jingle.Repo.Migrations.CreateApi.Show do
  use Ecto.Migration

  def change do
    create table(:shows) do
      add :structure, :text
      add :network, :string
      add :name, :string
      add :rate, :string
      add :notes, :text
      add :recording_day, :string

      timestamps()
    end

  end
end
