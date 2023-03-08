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

  def handle_event("validate", %{"_target" => ["pdf"]}, socket) do
    # IO.inspect(params)

    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("save", _params, socket) do
    # uploaded_files =
    #   consume_uploaded_entries(socket, :pdf, fn %{path: path}, entry ->
    #     Documents.create_upload_from_plug_upload(socket.assigns.current_user, %Plug.Upload{
    #       filename: entry.client_name,
    #       path: path,
    #       content_type: entry.client_type
    #     })
    #   end)

    {:noreply, push_patch(socket, to: Routes.book_library_index_path(socket, :index))}
  end

  defp error_to_string(:too_large), do: "Too large"
  defp error_to_string(:too_many_files), do: "You have selected too many files"
  defp error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
end
