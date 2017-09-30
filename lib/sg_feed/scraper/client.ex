defmodule SGFeed.Scraper.Client do
  @moduledoc """
  Adapter behaviour for any HTTP client so that scraper can
  use the client.
  """

  @doc """
  Get the HTML of the url provided.
  """
  @callback get_html(String.t) :: {:ok, String.t} | {:error, term}
end
