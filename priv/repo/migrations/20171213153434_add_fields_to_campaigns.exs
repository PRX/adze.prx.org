defmodule Jingle.Repo.Migrations.AddFieldsToCampaigns do
  use Ecto.Migration

  def change do
    rename table(:campaigns), :copy, to: :original_copy

    alter table(:campaigns) do
      add :edited_copy, :text
      add :must_say, :text
      add :due_date, :date
      add :notes, :text
      add :approved, :boolean
    end
  end
end
