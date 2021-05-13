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
    |> unique_constraint(:name, name: :index_for_report_name)
    |> unique_constraint(:file_date, file_date: :index_for_file_date)
  end


  def get_reports() do
    Report
    |> Repo.all()
  end

  def get_id_by_report_fields(name, file_date) do
    Report
    |> where([u], u.file_date == ^file_date and u.name == ^name)
    |> select([u], u.id)
    |> Repo.all
    |> List.first
  end

  def insert_report(params) do
    case get_id_by_report_fields(params.name, params.file_date) do
      nil -> Report.changeset(%Report{}, params) |> Repo.insert!
      id -> Repo.get!(Report, id)
    end
  end
end
