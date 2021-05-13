defmodule PayrollBackend.Graphql.Schema.ReportsType do
  use Absinthe.Schema.Notation

  alias PayrollBackend.{Resolvers, Repo, Report}

  object :reports_queries do
    field :get_reports, list_of :report do
      resolve fn _, _, _ ->
        {:ok, Repo.all(Report)}
      end
    end
  end

  object :reports_mutations do
    field :insert_reports, :report do
      arg :input, non_null(:report_input)
      resolve &Resolvers.Reports.insert_report/3
    end
  end

  object :report do
    field :id,          :string
    field :name,        :string
    field :file_date,   :string
    field :inserted_at,  :string
    field :updated_at,  :string
  end

  input_object :report_input do
    field :name,        :string
    field :file_date,   :string
  end
end
