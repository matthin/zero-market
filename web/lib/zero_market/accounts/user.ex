defmodule ZeroMarket.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ZeroMarket.Accounts.User


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :password_hash, :string
    field :password, :string, virtual: true
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> validate_length(:password, min: 12)
  end
end
