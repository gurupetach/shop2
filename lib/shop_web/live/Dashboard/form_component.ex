defmodule ShopWeb.Dashboard.FormComponent do
  @moduledoc """
  Deals with file uploads
  """

  use ShopWeb, :live_component
  alias Shop.Products

  @impl true
  def update(%{title: _title} = assigns, socket) do
    product = %Shop.Products.Product{}

    changeset = Products.product_struct(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:uploaded_files, [])
     |> assign(:changeset, changeset)
     |> allow_upload(:image,
       accept: ~w(.jpg .jpeg .png),
       max_entries: 1,
       max_file_size: 200_000_000
     )}
  end

  def handle_event("validate", %{"_target" => ["product", "name"]}, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", %{"_target" => ["product", "price"]}, socket) do
    {:noreply, socket}
  end

  def handle_event("validate", %{"_target" => ["image"]}, socket) do
    {:noreply, socket}
  end

  def handle_event(
        "validate",
        %{"image" => "", "product" => %{"name" => "", "price" => _price}},
        socket
      ) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event(
        "save",
        %{"product" => %{"name" => name, "price" => price}},
        socket
      ) do
    IO.inspect(name, label: "====================================")

    consume_uploaded_entries(socket, :image, fn %{path: path}, _entry ->
      dest = Path.join("priv/static/images/dashboard", "#{name}.jpg")

      File.cp!(path, dest)
      |> case do
        :ok -> {:ok, "uploaded"}
        :error -> {:postpone, "To be uploaded later"}
      end
    end)

    price = price |> String.to_integer()

    case Products.create_product(%{name: name, price: price, has_image?: true}) do
      {:ok, _product} ->
        {:noreply,
         socket
         |> put_flash(:info, "Product added to System")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
