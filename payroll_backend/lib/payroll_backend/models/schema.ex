defmodule PayrollBackend.Schema do
  @doc """
    base class of Ecto.Schema
  """
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      @primary_key {:id, :id, autogenerate: true}
      @foreign_key_type :id
      # in the future, if we want to track the time
      # then we need to have timestamps() enabled on the schema
      # and use changeset and migration to add extra field in the table
      # also we need to change GraphQL query here too.
      @timestamps_opts [type: :utc_datetime]
    end
  end
end
