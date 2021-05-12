defmodule PayrollBackend.Report do
  use PayrollBackend.Schema
  import Ecto.Query
  alias PayrollBackend.{Repo, Report, Record}

  schema "report" do
    field :name, :string
    field :file_date, :string

    has_many :record, Record
    timestamps()
  end

  def changeset(report, params \\ %{}) do
    validate = [:name, :file_date]
    report
    |> cast(params, validate)
    |> validate_required(validate)
  end


  def get_reports() do
    Report
    |> Repo.all()
  end

  def get_id_by_report_name(name) do
    Report
    |> where([u], u.name == ^name)
    |> select([:id])
    |> Repo.all
    |> List.first
  end

  def insert_report(params) do
    Report.changeset(%Report{}, params)
    |> Repo.insert!
  end
end
