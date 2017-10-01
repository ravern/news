defmodule SGFeedWeb.ArticleController do
  use SGFeedWeb, :controller
  alias SGFeed.Articles

  @doc """
  Renders a list of articles with filtering, pagination, etc.
  """
  def index(conn, _params) do
    articles = Articles.list_articles()
    render conn, "index.html", articles: articles
  end
end
