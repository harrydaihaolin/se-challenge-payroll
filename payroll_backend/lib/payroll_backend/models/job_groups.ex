defmodule PayrollBackend.JobGroups do
  use PayrollBackend.Schema
  import Ecto.Query
  alias PayrollBackend.{Repo, JobGroups}

  schema "job_groups" do
    field :name, :string, size: 10
    field :rate, :string
    timestamps()
  end

  def changeset(job_groups, params \\ %{}) do
    validate = [:name, :rate]
    job_groups
    |> cast(params, validate)
    |> validate_required(validate)
  end

  def get_rate_by_name(name) do
    JobGroups
    |> where([u], u.name == ^name)
    |> select([u], u.rate)
  end

  def insert_job_groups(params) do
    JobGroups.changeset(%JobGroups{}, params)
    |> Repo.insert!
  end
end
