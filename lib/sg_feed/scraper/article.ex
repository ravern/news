defmodule SGFeed.Scraper.Article do
  @moduledoc """
  Represents a single article, with all its possible metadata etc.
  """

  @type t
  defstruct [
    # Main content
    :base_url,
    :permalink,
    :category,
    :title,
    :subtitle,
    :highlight,
    :body,
    :thumbnail,
    :image,
    
    # Metadata
    :authors,
    :published_at,
  ]
end
