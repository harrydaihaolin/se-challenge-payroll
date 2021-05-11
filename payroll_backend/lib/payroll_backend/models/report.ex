defmodule PayrollBackend.Report do
  use PayrollBackend.Schema

  alias PayrollBackend.{Repo, Report, Record}

  schema "report" do
    field :name, :string
    field :file_date, :string

    has_many :record, Record
    timestamps()
  end

  def changeset(report, params \\ %{}) do
    report
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def get_reports() do
    Report
    |> Repo.all()
  end

  def insert_report(params) do
    Report.changeset(%Report{}, params)
    |> Repo.insert!
  end
end
