defmodule PayrollBackend.Repo.Migrations.CreateEmployeeTable do
  use Ecto.Migration

  def change do
    create table("employee") do
      add :employee_id, :integer
      timestamps()
    end
  end
end
