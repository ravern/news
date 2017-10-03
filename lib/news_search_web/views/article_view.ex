defmodule NewsSearchWeb.ArticleView do
  use NewsSearchWeb, :view

  @doc """
  Splits the articles into a list of rows, with `n` number of items
  in each row.
  """
  def split_articles(articles, n \\ 3) do
    Enum.chunk_every(articles, n)
  end
end
