defmodule PayrollBackend.Resolvers.Employee do
  alias PayrollBackend.Employee

  def insert_employee(_, %{input: input}, _) do
    {:ok, Employee.insert_employee(input)}
  end
end
