defmodule PayrollBackend.Repo.Migrations.CreateReportTable do
  use Ecto.Migration

  def change do
    create table("report") do
      add :name,      :string
      add :file_date, :string
      timestamps()
    end
  end
end
