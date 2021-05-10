defmodule PayrollBackend.Repo do
  use Ecto.Repo,
    otp_app: :payroll_backend,
    adapter: Ecto.Adapters.Postgres
end
