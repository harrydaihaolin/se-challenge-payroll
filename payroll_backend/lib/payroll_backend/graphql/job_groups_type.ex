defmodule PayrollBackend.Graphql.Schema.JobGroupsType do
  use Absinthe.Schema.Notation

  alias PayrollBackend.{Resolvers, Repo, JobGroups}

  object :job_groups_queries do
    field :get_job_groups, list_of :job_groups do
      resolve fn _, _, _ ->
        {:ok, Repo.all(JobGroups)}
      end
    end
  end

  object :job_groups_mutations do
    field :insert_job_groups, :job_groups do
      arg :input, non_null(:job_groups_input)
      resolve &Resolvers.JobGroups.insert_job_groups/3
    end
  end

  object :job_groups do
    field :name,        :string
    field :rate,        :string
    field :inserted_at,  :string
    field :updated_at,  :string
  end

  input_object :job_groups_input do
    field :name, :string
    field :rate, :string
  end
end
