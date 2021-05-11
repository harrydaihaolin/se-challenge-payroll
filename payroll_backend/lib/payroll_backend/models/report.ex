defmodule PayrollBackend.Report do
  use PayrollBackend.Schema

  alias PayrollBackend.{Repo, Report, JobGroups}

  schema "report" do
    field :name, :string
    field :file_date, :string

    has_many :job_group, JobGroups
    has_many :employee, through: [:job_group, :employee]
    has_many :record, through: [:employee, :record]
    timestamps()
  end

  def changeset(report, params \\ %{}) do
    report
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def get_report_by_id(id) do
    Repo.get(Report, id)
  end

  def insert_report(params) do
    Report.changeset(%Report{}, params)
    |> Repo.insert!
  end
end
