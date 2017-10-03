defmodule NewsSearch.Scraper.Client do
  @moduledoc """
  Adapter behaviour for any HTTP client so that scraper can
  use the client. Simply `use NewsSearch.Scraper.Client`.
  """

  @doc """
  Get the HTML of the url provided. It should also handle the nil case,
  preferably with an error.
  """
  @callback get_html(String.t | nil) :: {:ok, String.t} | {:error, term}

  @doc """
  `use NewsSearch.Scraper.Client` has to be called before you define the
  `get_html/1` function.
  """
  defmacro __using__(_ast) do
    quote do
      @behvaiour NewsSearch.Scraper.Client
      def get_html(nil), do: {:error, :url_is_nil}
    end
  end
end
