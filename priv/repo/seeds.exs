# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Shop.Repo.insert!(%Shop.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Shop.{Repo, Products}
alias Shop.Products.Product

Product |> Repo.delete_all()
Products.create_product(%{name: "Vitron-32-inch", price: 12000, has_image?: true})
Products.create_product(%{name: "Vitron-43-inch", price: 24000, has_image?: true})
Products.create_product(%{name: "samsung-55-inch", price: 46000, has_image?: true})
Products.create_product(%{name: "hoodie", price: 799, has_image?: true})
Products.create_product(%{name: "tshirt", price: 400, has_image?: true})
Products.create_product(%{name: "men-suit", price: 6000, has_image?: true})
Products.create_product(%{name: "women-shoes", price: 1450, has_image?: true})
