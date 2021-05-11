defmodule PayrollBackend.Employee do
  use PayrollBackend.Schema
  import Ecto.Query

  alias PayrollBackend.{Repo, Employee, JobGroups, Record}

  schema "employee" do
    field :employee_id, :decimal
    has_many :record, Record 
    belongs_to :job_groups, JobGroups
  end

  def changeset(employee, params \\ %{}) do
    validate = [:job_groups_id, :employee_id]
    employee
    |> cast(params, validate)
    |> validate_required(validate)
  end

  def get_employee_by_eid(employee_id) do    
    Employee
    |> where([u], u.employee_id == ^employee_id)
    |> Repo.all
  end

  def insert_employee(params) do
    Employee.changeset(%Employee{}, params)
    |> Repo.insert!
  end
end
