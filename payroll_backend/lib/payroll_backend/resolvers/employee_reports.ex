defmodule PayrollBackend.Resolvers.EmployeeReports do
  alias PayrollBackend.EmployeeReports

  def insert_employee_reports(_, %{input: input}, _) do
    {:ok, EmployeeReports.insert_employee_reports(input)}
  end
end
