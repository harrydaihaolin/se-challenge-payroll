defmodule PayrollBackend.Resolvers.Reports do
  alias PayrollBackend.Report

  def get_reports(_, _, _) do
    Report.get_reports()
  end
end
    # %{
    #   employee_id: employee_id,
    #   job_groups: job_groups,
    #   date: date,
    #   hours: hours,
    #   file_date: file_date,
    #   report_name: report_name
    # } = input
    # rate = JobGroups
    # employee = Employee.insert_employee(%{employee_id: employee_id})
    # report = Report.insert_report(%{name: report_name, file_date: file_date})
    # Record.insert_record(%{report_time: date, hours: hours, employee_id: Integer.to_string(employee.employee_id), job_groups_id: job_groups_id, report_id: report.id})
