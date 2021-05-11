defmodule PayrollBackend.Repo.Migrations.CreateEmployeeTable do
  use Ecto.Migration

  def change do
    create table("employee") do
      add :employee_id, :integer
      add :job_groups, references("job_groups"), null: false
      timestamps()
    end
  end
end
