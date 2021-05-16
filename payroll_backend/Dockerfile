FROM elixir:latest

# Create app directory and copy elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex manager
RUN mix local.hex --force
RUN mix local.rebar --force
# Compile the project
RUN mix deps.get
RUN mix deps.compile

EXPOSE 4000
CMD mix setup && mix phx.server
