defmodule PayrollBackend.Repo.Migrations.CreateRecordTable do
  use Ecto.Migration

  def change do
    create table("record") do
      add :report_time, :string
      add :hours,       :integer
      add :wage,        :integer
      add :currency,    :string, size: 4
      add :employee,    references("employee"),   null: false
      add :report,      references("report"),     null: false
      timestamps()
    end
  end
end
