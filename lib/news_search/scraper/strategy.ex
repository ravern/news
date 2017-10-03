defmodule NewsSearch.Scraper.Strategy do
  @moduledoc """
  Behaviour module for any strategy to be used with the scraper. One
  strategy should be defined per domain/sub-domain. Nothing more,
  nothing less.
  """

  @doc """
  The base url of the website.
  """
  @callback base_url() :: String.t

  @doc """
  List of categories and their corresponding paths.
  """
  @callback categories() :: [{atom, String.t}]

  @doc """
  Defines the attributes that can be extracted from
  the corresponding page. `:permalink` is automatically
  included in the `:feed` attributes (otherwise the scraper
  wouldn't work lol).
  """
  @callback attributes(:feed | :article) :: [atom]
end
