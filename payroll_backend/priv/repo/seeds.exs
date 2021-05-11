# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PayrollBackend.Repo.insert!(%PayrollBackend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Init Job Groups

alias PayrollBackend.{Repo, JobGroups}

Repo.insert! %JobGroups{
  name: "A",
  rate: "20"
}

Repo.insert! %JobGroups{
  name: "B",
  rate: "30"
}
