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
    |> unique_constraint(:employee_id, name: :index_for_employee_id)
  end

  def get_id_by_employee_id(employee_id) do
    Employee
    |> where([u], u.employee_id == ^employee_id)
    |> select([u], u.id)
    |> Repo.all
    |> List.first
  end

  def insert_employee(params) do
    case get_id_by_employee_id(params.employee_id) do
      nil -> Employee.changeset(%Employee{}, params) |> Repo.insert!
      num -> Repo.get!(Employee, num)
    end
  end
end
