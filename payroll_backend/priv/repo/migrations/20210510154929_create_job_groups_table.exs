defmodule PayrollBackend.Repo.Migrations.CreateJobGroupsTable do
  use Ecto.Migration

  def change do
    create table(:job_groups) do
      add :name, :string, size: 10
      add :rate, :string
      timestamps()
    end
  end
end
