defmodule PayrollBackend.Record do
  use PayrollBackend.Schema
  import Ecto.Query
  alias PayrollBackend.{Repo, Record, Employee, Report}

  schema "record" do
    field :report_time, :string
    field :hours,       :float
    field :wage,        :integer
    field :currency,    :string

    belongs_to :employee, Employee
    belongs_to :report, Report
    timestamps()
  end

  def changeset(record, params \\ %{}) do
    validate = [:report_time, :hours, :wage, :currency, :employee_id, :report_id]
    record
    |> cast(params, validate)
    |> validate_required(validate)
    |> unique_constraint(:report, name: :index_for_record)
  end

  def get_records() do
    Record
    |> Repo.all
  end

  def get_record_by_id(id) do
    Repo.get(Record, id)
  end

  def get_id_by_params(report_time, hours, employee_id) do
    Record
    |> where([u], u.report_time == ^report_time and u.hours == ^hours and u.employee_id == ^employee_id)
    |> select([u], u.id)
    |> Repo.all
    |> List.first
  end

  def insert_record(params) do
    case get_id_by_params(params.report_time, params.hours, params.employee_id) do
      nil -> Record.changeset(%Record{}, params) |> Repo.insert!
      id  -> Repo.get!(Record, id)
    end
  end
end
