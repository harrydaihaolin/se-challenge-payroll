defmodule PayrollBackend.Employee do
  use PayrollBackend.Schema
  import Ecto.Query

  alias PayrollBackend.{Repo, Employee, Record}

  schema "employee" do
    field :employee_id, :integer
    has_many :record, Record
    timestamps()
  end

  def changeset(employee, params \\ %{}) do
    validate = [:employee_id]
    employee
    |> cast(params, validate)
    |> validate_required(validate)
  end

  def get_id_by_employee_id(employee_id) do
    Employee
    |> where([u], u.employee_id == ^employee_id)
    |> select([u], u.id)
    |> Repo.all
    |> List.first
  end

  def insert_employee(params) do
    Employee.changeset(%Employee{}, params)
    |> Repo.insert!
  end
end
