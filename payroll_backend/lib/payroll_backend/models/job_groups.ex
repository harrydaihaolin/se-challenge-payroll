defmodule PayrollBackend.JobGroups do
  use PayrollBackend.Schema
  import Ecto.Query
  alias PayrollBackend.{Repo, JobGroups, Employee}

  schema "job_groups" do
    field :name, :string, size: 10
    field :rate, :string

    has_many :employee, Employee 
    has_many :record, through: [:employee, :record] 
    timestamps()
  end

  def changeset(job_groups, params \\ %{}) do
    validate = [:name, :rate]
    job_groups
    |> cast(params, validate)
    |> validate_required(validate)
  end

  def get_id_by_name(name) do
    JobGroups
    |> where([u], u.name == ^name)
    |> select([u], u.id)
  end

  def insert_job_groups(params) do
    JobGroups.changeset(%JobGroups{}, params)
    |> Repo.insert!
  end
end
