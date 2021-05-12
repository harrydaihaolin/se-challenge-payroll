defmodule PayrollBackend.Graphql.Schema do
  use Absinthe.Schema

  import_types __MODULE__.ReportsType
  import_types __MODULE__.RecordType
  import_types __MODULE__.JobGroupsType
  import_types __MODULE__.EmployeeType

  query do
    import_fields :reports_queries
    import_fields :record_queries
    import_fields :job_groups_queries
    import_fields :employee_queries
  end

  mutation do
    import_fields :reports_mutations
    import_fields :record_mutations
    import_fields :job_groups_mutations
    import_fields :employee_mutations
  end
end
