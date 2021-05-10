defmodule PayrollBackend.Graphql.Schema do
  use Absinthe.Schema

  import_types __MODULE__.EmployeeReportsType

  query do
    import_fields :employee_reports_queries
  end

  mutation do
    import_fields :employee_reports_mutations
  end
end
