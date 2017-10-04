defmodule NewsSearch.Scraper do
  @moduledoc """
  Interface to the scraper portion of this app.
  """

  alias NewsSearch.Scraper.Options
  require Logger

  @doc """
  Starts up a Flow pipeline and scraping session, which
  scrape according to the options provided.

  ## Options

      `:strategies` - List of strategies to use in the scraping session.

      `:client` - HTTP client to use to perform requests.

      `:insert?` - Whether to insert the article into the db once fetched.
                   If true, then articles will be inserted into the db, and
                   the corresponding Ecto structs will be returned. Otherwise,
                   the `NewsSearch.Scraper.Article` structs will be returned
  """
  @spec scrape(keyword()) :: [NewsSearch.Scraper.Article.t]
  def scrape(opts \\ []) do
    opts = Options.apply_defaults(opts)
    strategies = opts[:strategies]
    timeout = opts[:timeout]

    # Pipeline
    strategies
    |> Stream.flat_map(&get_categories/1)
    |> Task.async_stream(&fetch_and_parse_feed(&1, opts), max_concurrency: 5, timeout: timeout)
    |> Stream.flat_map(fn({:ok, articles}) -> articles end)
    |> Task.async_stream(&fetch_and_parse_article(&1, opts), max_concurrency: 10, timeout: timeout)
    |> Stream.map(fn({:ok, article}) -> article end)
    |> Stream.filter(&Kernel.!=(&1, nil))
    |> Enum.to_list()
  end

  # Returns a list of categories and their corresponding
  # strategies.
  defp get_categories(strategy) do
    strategy.categories()
    |> Enum.map(&{strategy, &1})
  end

  # Fetches the feed data based on category given, parses the data,
  # and returns the list of article maps from the data.
  defp fetch_and_parse_feed({strategy, {category_name, category_path}}, opts) do
    # Take note that maps are used until the last part, where they are converted
    # to full-fledged article structs

    client = opts[:client]
    category_url = strategy.base_url <> category_path
    info = %{base_url: strategy.base_url, category: to_string(category_name)}

    case client.get_html(category_url) do
      {:ok, html} ->
        html
        |> extract_articles(strategy)
        |> Enum.map(&Map.merge(&1, info)) # Add in the info to the Article struct
        |> Enum.map(&{strategy, &1})

      {:error, reason} ->
        # TODO Better error handling
        Logger.debug("Failed to fetch feed due to reason: #{reason}")
        []
    end
  end

  # Fetches more specific article data based on article given, parses
  # the data and returns the article struct.
  defp fetch_and_parse_article({strategy, article}, opts) do
    client = opts[:client]

    case client.get_html(article.permalink) do
      {:ok, html} ->
        html
        |> extract_article_data(strategy, :article)
        |> Map.merge(article)
      {:error, reason} ->
        # TODO Better error handling
        Logger.debug("Failed to fetch article due to reason: #{reason}")
        nil
    end
  end

  # Extracts the articles from HTML using strategy
  defp extract_articles(html, strategy) do
    html
    |> strategy.articles()
    |> Enum.map(&{extract_article_data(&1, strategy, :feed), &1})
    |> Enum.map(&put_permalink(&1, strategy))
  end

  # Puts the permalink into the article
  defp put_permalink({article, html}, strategy) do
    Map.put(article, :permalink, strategy.permalink(html))
  end

  # Extracts article info out from the HTML, based on the type of attributes
  # it is given (:feed or :article)
  defp extract_article_data(html, strategy, type) do
    type
    |> strategy.attributes()
    |> Enum.reduce(%{}, &Map.put(&2, &1, apply(strategy, &1, [html])))
  end
end
