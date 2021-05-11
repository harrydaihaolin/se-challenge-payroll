defmodule PayrollBackend.Repo.Migrations.CreateRecordTable do
  use Ecto.Migration

  def change do
    create table("record") do
      add :report_time, :string
      add :hours,       :decimal
      add :employee,    references("employee"),   null: false
      timestamps()
    end
  end
end
