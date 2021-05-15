defmodule PayrollBackend.Graphql.Schema.EmployeeType do
  use Absinthe.Schema.Notation

  alias PayrollBackend.{Resolvers, Repo, Employee}

  object :employee_queries do
    field :get_employee, list_of :employee do
      resolve fn _, _, _ ->
        {:ok, Repo.all(Employee)}
      end
    end
  end

  object :employee_mutations do
    field :insert_employee, :employee do
      arg :input, non_null(:employee_input)
      resolve &Resolvers.Employee.insert_employee/3
    end
  end

  object :employee do
    field :employee_id, :integer
    field :inserted_at,  :string
    field :updated_at,  :string
  end

  input_object :employee_input do
    field :employee_id, :integer
  end
end
