defmodule PayrollBackend.Repo.Migrations.CreateRecordTable do
  use Ecto.Migration

  def change do
    create table("record") do
      add :report_time, :string
      add :hours,       :float
      add :wage,        :integer
      add :currency,    :string, size: 4
      add :employee_id,    references("employee"),   null: false
      add :report_id,      references("report"),     null: false
      timestamps()
    end

    create unique_index(:record, ~w(report_time hours employee_id)a, name: :index_for_record)
  end
end
