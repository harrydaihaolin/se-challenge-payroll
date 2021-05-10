defmodule PayrollBackend.EmployeeReports do
  use PayrollBackend.Schema
  import Ecto.Query
  alias PayrollBackend.{Repo, EmployeeReports}

  schema "employee_reports" do
    field :employee_id,    :string
    field :start_date,     :string
    field :end_date,       :string
    field :amount_paid,    :string
    timestamps()
  end

  def changeset(employee_reports, params \\ %{}) do
    validate = [:employee_id, :start_date, :end_date, :amount_paid]
    employee_reports
    |> cast(params, validate)
    |> validate_required(validate)
  end

  defp get_employee_reports(id) do
    Repo.get(EmployeeReports, id)
  end

  def insert_employee_reports(params) do
    EmployeeReports.changeset(%EmployeeReports{}, params)
    |> Repo.insert
  end
end
