defmodule NewsSearchWeb.LayoutView do
  use NewsSearchWeb, :view

  @flashes [:info, :success, error: :danger]

  @doc """
  Renders all the flashes defined in the module attribute.
  """
  def render_flashes(conn) do
    Enum.map(@flashes, &render_flash(conn, &1))
  end

  # Renders a single flash
  defp render_flash(conn, key) when is_atom(key) do
    render_flash(conn, {key, key})
  end
  defp render_flash(conn, {key, class}) do
    case get_flash(conn, key) do
      nil -> ""
      text -> content_tag(:div, text, class: "alert alert-#{class}")
    end
  end
end
