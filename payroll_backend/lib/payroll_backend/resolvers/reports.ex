defmodule PayrollBackend.Resolvers.Reports do
  alias PayrollBackend.{Employee, Record, Report, JobGroups}

  def insert_reports(_, %{input: input}, _) do
    %{
      employee_id: employee_id,
      job_groups: job_groups,
      date: date,
      hours: hours,
      file_date: file_date,
      report_name: report_name
    } = input
    job_groups_id = JobGroups.get_id_by_name(job_groups)
    employee = Employee.insert_employee(%{employee_id: employee_id, job_groups_id: job_groups_id}) 
    report = Report.insert_report(%{name: report_name, file_date: file_date})
    Record.insert_record(%{report_time: date, hours: hours, employee_id: employee.id, job_groups_id: job_groups_id, report_id: report.id})
  end
end
