defmodule Jingle.Repo.Migrations.CreateApi.Sponsor do
  use Ecto.Migration

  def change do
    create table(:sponsors) do
      add :name, :string
      add :billing_info, :text
      add :notes, :text

      timestamps()
    end

  end
end
