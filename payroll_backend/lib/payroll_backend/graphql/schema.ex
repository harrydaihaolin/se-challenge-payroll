defmodule PayrollBackend.Graphql.Schema do
  use Absinthe.Schema

  import_types __MODULE__.ReportsType

  query do
    import_fields :reports_queries
  end

  mutation do
    import_fields :reports_mutations
  end
end
