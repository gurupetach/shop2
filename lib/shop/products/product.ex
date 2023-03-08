defmodule Shop.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :price, :integer
    field(:has_image?, :boolean, default: false)


    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :has_image?])
    |> validate_required([:name, :price])
  end
end
