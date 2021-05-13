defmodule PayrollBackend.Graphql.Schema.RecordType do
  use Absinthe.Schema.Notation

  alias PayrollBackend.{Resolvers, Repo, Record}

  object :record_queries do
    field :get_record, list_of :record do
      resolve fn _, _, _ ->
        {:ok, Repo.all(Record)}
      end
    end
  end

  object :record_mutations do
    field :insert_record, :record do
      arg :input, non_null(:record_input)
      resolve &Resolvers.Record.insert_record/3
    end
  end

  object :record do
    field :report_time, :string
    field :hours,       :integer
    field :wage,        :integer
    field :currency,    :string
    field :employee_id, :integer
    field :report_id,   :integer
    field :inserted_at,  :string
    field :updated_at,  :string
  end

  input_object :record_input do
    field :report_time, :string
    field :hours,       :integer
    field :wage,        :integer
    field :currency,    :string
    field :employee_id, :integer
    field :report_name, :string
    field :report_date, :string
  end
end
