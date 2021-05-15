defmodule PayrollReport do
  defstruct [:employee_id, :pay_period, :amount_paid]
end

defmodule PayPeriod do
  defstruct [:start_date, :end_date] 
end

defmodule PayrollBackend.Resolvers.PayrollReport do
  alias PayrollBackend.{Report, Employee}

  def get_payroll_report_by_report_attributes(_, %{input: input}, _) do
      {:ok, get_payroll_report_by_report_attributes(input)}
  end

  def get_payroll_report(_, _, _) do
      {:ok, get_payroll_report()}
  end

  defp range_of_date_records_parser(records) do
    records = 
      records
      |> Enum.map(fn record -> record.report_time end)
      |> Enum.map(fn report_time ->  
            Timex.parse!(report_time, "%-d/%-m/%Y", :strftime) 
            |> NaiveDateTime.to_date 
      end)
      |> Enum.sort(Date)

    {records |> List.first, records |> List.last}
  end

  def range_of_date_parser(employee_id) do
    range_of_date = 
      Employee.get_records_from_employee(employee_id) 
      |> range_of_date_records_parser

    beginning_of_date = Date.beginning_of_month(elem(range_of_date, 0))
    end_of_date = Date.end_of_month(elem(range_of_date, 1))
    months = Integer.floor_div(Date.diff(end_of_date, beginning_of_date), 30) 
    {beginning_of_date, months}
  end

  defp range_of_date_parser_by_report_id(report_id) do
      range_of_date = Report.get_records_from_report(report_id) 
      |> range_of_date_records_parser
      beginning_of_date = Date.beginning_of_month(elem(range_of_date, 0))
      end_of_date = Date.beginning_of_month(elem(range_of_date, 1))
      months = Integer.floor_div(Date.diff(end_of_date, beginning_of_date), 30) + 1
      {beginning_of_date, months}
  end

  def pay_period_parser(beginning_of_date, months) do
    Stream.iterate(beginning_of_date, fn date -> 
        Date.add(Date.end_of_month(date), 1)
      end) 
      |> Enum.take(months) 
      |> Enum.map(fn begin -> date_accumulator(begin) end)
    |> List.flatten
  end

  def get_payroll_report() do
    Employee.get_employee_ids
    |> Enum.map(fn id -> 
      {beginning_of_date, months} = range_of_date_parser(id)
      pay_period_parser(beginning_of_date, months)
      |> Enum.map(fn
        pay_period_pair -> 
          %PayrollReport{
            employee_id: id,
            pay_period: struct!(PayPeriod, stringify_pay_period(pay_period_pair)),
            amount_paid: amount_paid_calcultor(pay_period_pair, id)
          }
      end)
    end)
    |> List.flatten()
    |> Enum.filter(fn payroll_report -> payroll_report.amount_paid != 0 end)
  end

  defp get_payroll_report_by_report_attributes(input) do
    report_id = Report.get_id_by_report_fields(input.report_name, input.file_date)
    {beginning_of_date, months} = range_of_date_parser_by_report_id(report_id)

    Report.get_employee_id_from_report(report_id)
    |> Enum.map(fn employee_id ->
      Stream.iterate(beginning_of_date, fn date -> 
        Date.add(Date.end_of_month(date), 1)
      end) 
      |> Enum.take(months) 
      |> Enum.map(fn begin -> date_accumulator(begin) end)
      |> List.flatten 
      |> List.flatten
      |> Enum.map(fn pay_period -> %PayrollReport{
        employee_id: employee_id,
        pay_period: struct!(PayPeriod, stringify_pay_period(pay_period)),
        amount_paid: amount_paid_calcultor(pay_period, employee_id, report_id)
      } end)
    end)
  end

  defp record_processor(record, range) do
    amount_paid = record
    |> Enum.map(fn record -> [record.wage, record.report_time] end)
    |> Enum.map(fn small_record -> List.replace_at(small_record, 1, Timex.parse!(List.last(small_record), "%-d/%-m/%Y", :strftime)) end)
    |> Enum.map(fn small_record -> List.replace_at(small_record, 1, NaiveDateTime.to_date(List.last(small_record))) end)
    |> Enum.filter(fn small_record -> Enum.member?(range, List.last(small_record)) end)
    |> Enum.map(fn small_record -> List.first(small_record) end)
    |> Enum.reduce(0, fn x, acc -> x + acc end)
    "$#{amount_paid}"
  end

  def amount_paid_calcultor(map, employee_id, report_id \\ 0) do
    range = Date.range(map.start_date, map.end_date)
    case report_id do
      0 -> 
        Employee.get_records_from_employee(employee_id)
        |> record_processor(range)
      _ ->
        Report.get_records_from_report(report_id)
        |> Enum.filter(fn record -> Enum.member?(Report.get_employee_id_from_report(report_id), record.employee_id) end)
        |> record_processor(range)
    end
  end

  def date_accumulator(date) do 
    first_map = 
      Map.new()
      |> Map.put(:start_date, date)
      |> Map.put(:end_date, Date.add(date, 14))
    second_map = 
      Map.new()
      |> Map.put(:start_date, Date.add(date, 15))
      |> Map.put(:end_date, Date.end_of_month(date))
    [first_map, second_map]
  end

  def stringify_pay_period(pay_period_pair) do
    Map.new()
    |> Map.put(:start_date, Date.to_string(Map.get(pay_period_pair, :start_date)))
    |> Map.put(:end_date, Date.to_string(Map.get(pay_period_pair, :end_date)))
  end
end
