defmodule PayrollBackend.Repo.Migrations.CreateEmployeeTable do
  use Ecto.Migration

  def change do
    create table("employee") do
      add :employee_id, :integer
      timestamps()
    end

    create unique_index(:employee, ~w(employee_id)a, name: :index_for_employee_id)
  end
end
