defmodule Shop.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:name, :string)
      add(:price, :integer)
      add(:has_image?, :boolean, default: false)

      timestamps()
    end

    create(unique_index(:products, [:name], name: :unique_index_for_products_duplicate_entries))
  end
end
