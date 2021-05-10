FROM elixir:latest

# Create app directory and copy elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex manager
RUN mix local.hex --force
# Compile the project
RUN mix do compile

EXPOSE 4000
CMD ["./run.sh"]
