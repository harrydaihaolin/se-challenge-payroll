defmodule PayrollReport do
  defstruct [:employee_id, :pay_period, :amount_paid]
end

defmodule PayPeriod do
  defstruct [:start_date, :end_date] 
end

defmodule PayrollBackend.Resolvers.PayrollReport do
  def get_payroll_report_by_report_id(_, %{input: input}, _) do
    {:ok, %PayrollReport{
      employee_id: "1",
      pay_period: %PayPeriod{
        start_date: "2020-01-01",
        end_date: "2020-01-05"
      },
      amount_paid: "$80.00"
    }}
  end
end
