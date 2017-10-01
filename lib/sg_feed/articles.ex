defmodule SGFeed.Articles do
  @moduledoc """
  Articles context. Perform CRUD, post liking, etc through this
  context.
  """

  alias SGFeed.Repo
  alias SGFeed.Articles.Article

  @doc """
  Lists articles saved in the database.
  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Creates an article from a set of attributes.
  """
  def create_article(attrs) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end
end
