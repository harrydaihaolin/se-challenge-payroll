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
    |> unique_constraint(:employee_id, name: :index_for_employee_id, message: "Employee ID has already been taken")
  end

  def get_employee_ids() do
    Employee
    |> select([u], u.employee_id)
    |> Repo.all
    |> Enum.sort
  end

  def get_id_by_employee_id(employee_id) do
    Employee
    |> where([u], u.employee_id == ^employee_id)
    |> select([u], u.id)
    |> Repo.one()
  end

  def get_records_from_employee(employee_id) do
    Employee
    |> where([u], u.employee_id == ^employee_id)
    |> preload(:record)
    |> Repo.all
    |> Enum.map(fn employee -> Map.get(employee, :record) end)
    |> List.flatten
  end

  def insert_employee(params) do
    Employee.changeset(%Employee{}, params)
    |> Repo.insert()
    |> case do
      {:ok, data} -> {:ok, data}
      {:error, _} -> {:error, "failed to insert employee"}
    end
  end
end
