defmodule PayrollBackend.Repo.Migrations.CreateReportTable do
  use Ecto.Migration

  def change do
    create table("report") do
      add :name,      :string
      add :file_date, :string
      timestamps()
    end

    create unique_index(:report, ~w(name file_date)a, name: :index_for_report)
  end
end
