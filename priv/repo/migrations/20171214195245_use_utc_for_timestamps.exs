defmodule Jingle.Repo.Migrations.UseUtcForTimestamps do
  use Ecto.Migration

  def change do
    alter table(:campaigns) do
      modify :inserted_at, :utc_datetime
      modify :updated_at, :utc_datetime
      modify :due_date, :utc_datetime
    end

    alter table(:sponsors) do
      modify :inserted_at, :utc_datetime
      modify :updated_at, :utc_datetime
    end

    alter table(:creatives) do
      modify :inserted_at, :utc_datetime
      modify :updated_at, :utc_datetime
    end

    alter table(:podcasts) do
      modify :inserted_at, :utc_datetime
      modify :updated_at, :utc_datetime
    end

  end
end
