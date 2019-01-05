defmodule AppAdmin.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field(:name, :string)
    timestamps()

    belongs_to(:app, AppAdmin.App)
  end

  def changeset(role, params) do
    role
    |> cast(params, [:name])
    |> validate_required([:name])
    |> assoc_constraint(:app)
  end
end