defmodule SGFeedWeb.PageController do
  use SGFeedWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
