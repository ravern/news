defmodule SGFeed.Articles.Article do
  @moduledoc """
  Defines an article in the context of the database.
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias SGFeed.Articles.Article

  @required_fields [
    :base_url,
    :permalink, :category,
    :title,
    :body,
  ]
  @optional_fields [
    :subtitle,
    :highlight,
    :body,
    :thumbnail,
    :image,
    :author,
    :published_at,
  ]

  schema "articles" do
    # Main content
    field :base_url, :string
    field :permalink, :string
    field :category, :string
    field :title, :string
    field :subtitle, :string
    field :highlight, :string
    field :body, :string
    field :thumbnail, :string
    field :image, :string
    
    # Metadata
    field :author, :string
    field :published_at, :naive_datetime
  end

  @doc false
  def changeset(%Article{} = article, attrs \\ %{}) do
    article
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:permalink)
  end
end
