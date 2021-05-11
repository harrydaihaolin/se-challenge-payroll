defmodule PayrollBackend.Record do
  use PayrollBackend.Schema

  alias PayrollBackend.{Repo, Record, Employee, Report}

  schema "record" do
    field :report_time, :string
    field :hours,       :integer
    field :wage,        :integer
    field :currency,    :string

    belongs_to :employee, Employee
    belongs_to :report, Report
    timestamps()
  end

  def changeset(record, params \\ %{}) do
    validate = [:report_time, :hours, :employee_id, :report_id]
    record
    |> cast(params, validate)
    |> validate_required(validate)
  end

  def get_record_by_id(id) do
    Repo.get(Record, id)
  end

  def insert_record(params) do
    Record.changeset(%Record{}, params)
    |> Repo.insert!
  end
end
