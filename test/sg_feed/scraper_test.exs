defmodule SGFeed.ScraperTest do
  use ExUnit.Case, async: true

  alias SGFeed.Scraper
  alias SGFeed.Scraper.{Article, MockStrategy, MockClient}

  test "scrapes the mock client using the mock strategy correctly" do
    articles =
      [strategies: [MockStrategy], client: MockClient]
      |> Scraper.scrape()

    # Testing body is enough
    # Note: It doesn't have to return in the correct order,
    # in this case it does because the runtime of each article
    # is (nearly) instant
    assert [
      %Article{body: "Body of article 1"},
      %Article{body: "Body of article 2"},
      %Article{body: "Body of article 3"},
      %Article{body: "Body of article 4"},
      %Article{body: "Body of article 5"},
    ] = articles
  end
end
