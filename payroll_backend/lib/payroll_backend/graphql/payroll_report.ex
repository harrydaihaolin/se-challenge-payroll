defmodule PayrollBackend.Graphql.Schema.PayrollReportType do
  use Absinthe.Schema.Notation

  alias PayrollBackend.{Resolvers}

  object :payroll_report_queries do
    field :get_payroll_report_by_report_attributes, list_of :employee_report do
      arg :input, non_null(:payroll_report_input)
      resolve &Resolvers.PayrollReport.get_payroll_report_by_report_attributes/3
    end

    field :get_payroll_report, list_of :employee_report do
      resolve &Resolvers.PayrollReport.get_payroll_report/3
    end
  end

  object :payroll_report_mutations do

  end

  object :employee_report do
    field :employee_id, :string
    field :pay_period,  :pay_period
    field :amount_paid, :string
  end

  object :pay_period do
    field :start_date,   :string
    field :end_date,     :string
  end

  input_object :payroll_report_input do
    field :report_name, :string
    field :file_date,   :string
  end
end
