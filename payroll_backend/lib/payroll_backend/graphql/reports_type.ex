defmodule PayrollBackend.Graphql.Schema.ReportsType do
  use Absinthe.Schema.Notation

  alias PayrollBackend.Resolvers

  object :reports_queries do

  end

  object :reports_mutations do
    field :insert_employee_reports, :record do
      arg :input, non_null(:csv_input)
      resolve &Resolvers.Reports.insert_reports/3
    end
  end

  input_object :csv_input do
    field :employee_id, :string
    field :job_groups,  :string
    field :date,        :string
    field :hours,       :string
    field :file_date,   :string
    field :report_name, :string
  end

  object :record do
    field :report_time,   :string
    field :hours,         :integer
    field :employee_id,   :id
    field :job_groups_id, :id
    field :report_id,     :id
    field :created_at,    :string
    field :updated_at,    :string
  end

  object :result do
    field :employee_id,   :string
    field :start_date,     :string
    field :end_date,       :string
    field :amount_paid,   :string
  end
end
