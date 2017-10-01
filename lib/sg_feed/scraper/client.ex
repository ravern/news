defmodule SGFeed.Scraper.Client do
  @moduledoc """
  Adapter behaviour for any HTTP client so that scraper can
  use the client.
  """

  @doc """
  Get the HTML of the url provided. It should also handle the nil case,
  preferably with an error.
  """
  @callback get_html(String.t | nil) :: {:ok, String.t} | {:error, term}
end
