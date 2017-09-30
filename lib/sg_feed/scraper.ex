defmodule SGFeed.Scraper do
  @moduledoc """
  Interface to the scraper portion of this app.
  """

  alias SGFeed.Scraper.Options

  @doc """
  Starts up a Flow pipeline and scraping session, which
  scrape according to the options provided.

  ## Options

      `:strategies` - List of strategies to use in the scraping session.

      `:client` - HTTP client to use to perform requests.

      `:insert?` - Whether to insert the article into the db once fetched.
                   If true, then articles will be inserted into the db, and
                   the corresponding Ecto structs will be returned. Otherwise,
                   the `SGFeed.Scraper.Article` structs will be returned.
  """
  @spec scrape(keyword()) :: [SGFeed.Scraper.Article.t]
  def scrape(opts \\ []) do
    opts = Options.apply_defaults(opts)
    strategies = opts[:strategies]

    # Pipeline
    strategies
    |> Flow.from_enumerable()
    |> Flow.flat_map(&get_categories/1)
    |> Flow.flat_map(&fetch_and_parse_feed(&1, opts))
    |> Flow.flat_map(&fetch_and_parse_article(&1, opts))
    |> Flow.map(&insert_if_needed(&1, opts))
    |> Enum.to_list()
  end

  @doc """
  Returns a list of categories and their corresponding
  strategies.
  """
  def get_categories(strategy) do
    [{strategy, category}]
  end

  @doc """
  Fetches the feed data based on category given, parses the data,
  and returns the list of article structs from the data.
  """
  def fetch_and_parse_feed({strategy, category}, opts) do
    [{strategy, article}]
  end

  @doc """
  Fetches more specific article data based on article given, parses
  the data and returns the article struct.
  """
  def fetch_and_parse_article({strategy, article}, otps) do
    article
  end

  @doc """
  Inserts the article into the DB and returns the Ecto struct if the
  `insert?` option is passed.
  """
  def insert_if_needed(article, opts) do
    article
  end
end
