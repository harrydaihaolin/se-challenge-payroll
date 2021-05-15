defmodule PayrollBackend.Resolvers.Reports do
  alias PayrollBackend.Report

  def get_reports(_, _, _) do
    Report.get_reports()
  end

  def check_report(_, %{input: input}, _) do
    {:ok, Report.get_id_by_report_fields(input.name, input.file_date)}
  end

  def insert_report(_, %{input: input}, _) do
    {:ok, Report.insert_report(input)}
  end
end
