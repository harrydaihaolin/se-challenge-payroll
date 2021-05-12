defmodule PayrollBackend.Resolvers.JobGroups do
  alias PayrollBackend.JobGroups

  def insert_job_groups(_, %{input: input}, _) do
    {:ok, JobGroups.insert_job_groups(input)}
  end
end
