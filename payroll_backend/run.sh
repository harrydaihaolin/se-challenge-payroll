#!/bin/sh
# With help from https://dogsnog.blog/2018/02/02/a-docker-based-development-environment-for-elixirphoenix/
set -e

mix ecto.create
mix ecto.migrate
# run seeds file for job groups A and B 
mix run priv/repo/seeds.exs 
mix phx.server
