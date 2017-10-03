defmodule NewsSearch.Scraper.Options do
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
      timeout: timeout(),
    ]

    # Merge
    Keyword.merge(defaults, opts)
  end

  # Hardcoded defaults
  @strategies [
    NewsSearch.Scraper.Strategy.TheNewPaper,
  ]
  @client NewsSearch.Scraper.Client.HTTPoison
  @timeout 10000

  # Fetch from config, if nil then hardcoded defaults
  defp config,     do: Application.get_env(:sg_news, :scraper, [])
  defp strategies, do: Keyword.get(config(), :strategies, @strategies)
  defp client,     do: Keyword.get(config(), :client, @client)
  defp timeout,    do: Keyword.get(config(), :timeout, @timeout)
end
