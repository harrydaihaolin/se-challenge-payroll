defmodule PayrollBackend.Graphql.Schema.ReportsType do
  use Absinthe.Schema.Notation

  alias PayrollBackend.Resolvers

  object :reports_queries do
    field :get_reports, :report do
      resolve &Resolvers.Reports.get_reports/3
    end
  end

  object :reports_mutations do

  end

  object :report do
    field :name,        :string
    field :file_date,   :string
    field :created_at,  :string
    field :updated_at,  :string
  end
end
