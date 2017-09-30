defmodule SGFeed.Scraper.Options do
  @moduledoc """
  Utility functions to provide default options, fetch options
  from config, and do some intial processing.
  """

  @doc """
  Applies defaults to the list of options passed in.

  Returns a keyword list of options.
  """
  def apply_defaults(opts) do
    defaults = [
      strategies: strategies(),
      client: client(),
    ]

    # Merge
    Keyword.merge(defaults, opts)
  end

  # Hardcoded defaults
  @strategies [
    SGFeed.Scraper.Strategy.TheNewPaper,
  ]
  @client SGFeed.Scraper.Client.HTTPoison

  # Fetch from config, if nil then hardcoded defaults
  defp config,     do: Application.get_env(:sg_news, :scraper, [])
  defp strategies, do: Keyword.get(config, :strategies, @strategies)
  defp client,     do: Keyword.get(config, :client, @client)
end
