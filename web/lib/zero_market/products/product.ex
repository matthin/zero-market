defmodule ZeroMarket.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias ZeroMarket.Products.Product


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :description, :string
    field :title, :string
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(%Product{} = product, attrs) do
    product
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
