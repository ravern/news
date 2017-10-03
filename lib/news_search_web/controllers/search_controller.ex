defmodule NewsSearchWeb.SearchController do
  use NewsSearchWeb, :controller
  alias NewsSearch.Articles

  @doc """
  Renders the initial search form.
  """
  def new(conn, _params) do
    render conn, "new.html"
  end

  @doc """
  Performs the actual searching and renders the results.
  """
  def index(conn, _params) do
    render conn, "index.html"
  end
end
