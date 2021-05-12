defmodule PayrollBackend.Resolvers.Record do
  alias PayrollBackend.{Record, Employee}

  def insert_record(_, %{input: input}, _) do
    {:ok, input
    |> Map.get_and_update!(:employee_id, fn current_value -> 
      {current_value, Employee.get_id_by_employee_id(current_value)}
    end)
    |> elem(1)
    |> Record.insert_record}
  end
end
