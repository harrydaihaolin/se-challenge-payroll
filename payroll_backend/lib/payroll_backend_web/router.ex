defmodule PayrollBackendWeb.Router do
  use PayrollBackendWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["http://localhost:3000", "http://127.0.0.1:3000"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: PayrollBackend.Graphql.Schema,
      socket: PayrollBackendWeb.UserSocket

    if Mix.env == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: PayrollBackend.Graphql.Schema,
        socket: PayrollBackendWeb.UserSocket,
        interface: :playground
    end
  end
end
