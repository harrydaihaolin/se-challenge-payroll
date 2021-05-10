defmodule PayrollBackend.Repo.Migrations.AddEmployeeReportsTable do
  use Ecto.Migration

  def change do
    create table("employee_reports") do
      add :employee_id,  :string, null: false
      add :start_date,   :string, null: false
      add :end_date,     :string, null: false
      add :amount_paid,  :string, null: false
      timestamps()
    end
  end
end
