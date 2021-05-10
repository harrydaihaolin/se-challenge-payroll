defmodule PayrollBackend.Graphql.Schema.EmployeeReportsType do
  use Absinthe.Schema.Notation

  alias PayrollBackend.{Resolvers, EmployeeReports}

  object :employee_reports_queries do
    field :employee_reports, list_of :employee_reports do
      resolve fn _, _, _ ->
        case PayrollBackend.Repo.all(EmployeeReports) do
          nil -> {:error, "Employees Reports cannot be found"}
          employee_reports -> {:ok, employee_reports}
        end
      end
    end
  end

  object :employee_reports_mutations do
    field :insert_employee_reports, :employee_reports do
      arg :input, non_null(:employee_reports_input)
      resolve &Resolvers.EmployeeReports.insert_employee_reports/3
    end
  end

  input_object :employee_reports_input do
    field :employee_id, :string
    field :start_date,  :string
    field :end_date,    :string
    field :amount_paid, :string
  end

  object :employee_reports do
    field :id,         :id
    field :employee_id, :string
    field :start_date,  :string
    field :end_date,    :string
    field :amount_paid, :string
    field :created_at, :string
    field :updated_at, :string
  end
end
