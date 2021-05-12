# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :payroll_backend,
  ecto_repos: [PayrollBackend.Repo]

# Configures the endpoint
config :payroll_backend, PayrollBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wDXAt1uUu1AMQTV9Pw+6Nh218heDmAo6elCK0/PQuqDVvYj/ws/IxcdoZyTUQ2ug",
  render_errors: [view: PayrollBackendWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PayrollBackend.PubSub,
  live_view: [signing_salt: "aYlKvO/h"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# CORS enable
config :cors_plug,
  origin: ["http://localhost:3000", "http://127.0.0.1:3000"],
  max_age: 86400,
  method: ["GET", "POST"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
