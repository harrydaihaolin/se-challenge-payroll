defmodule PayrollBackend.Resolvers.Record do
  alias PayrollBackend.{Record, Employee, Report}

  def insert_record(_, %{input: input}, _) do
    {:ok, input |> record_parser}
  end

  def record_parser(input) do
    id = input
    |> Map.get(:employee_id)
    Employee.insert_employee(%{
      employee_id: id
    })
    input
    |> Map.get_and_update!(:employee_id, fn current_value -> 
      {current_value, Employee.get_id_by_employee_id(current_value)}
    end)
    |> elem(1)
    |> Map.put(:report_id, Report.get_id_by_report_fields(input.report_name, input.report_date))
    |> Map.delete(:report_name)
    |> Map.delete(:report_date)
    |> Record.insert_record()
  end
end
