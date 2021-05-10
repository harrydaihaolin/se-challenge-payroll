defmodule PayrollBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PayrollBackend.Repo,
      # Start the Telemetry supervisor
      PayrollBackendWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PayrollBackend.PubSub},
      # Start the Endpoint (http/https)
      PayrollBackendWeb.Endpoint
      # Start a worker by calling: PayrollBackend.Worker.start_link(arg)
      # {PayrollBackend.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PayrollBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PayrollBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
