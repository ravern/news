defmodule SGFeed.Scraper.Strategy.TheNewPaper do
  @moduledoc false
  @behaviour SGFeed.Scraper.Strategy

  def base_url, do: "http://www.tnp.sg"

  def categories do
    [
      main: "/news",
      sports: "/sports",
      entertainment: "/entertainment",
      lifestyle: "/lifestyle",
      racing: "/racing",
    ]
  end

  def attributes(:feed) do
    [
      :title,
      :thumbnail,
    ]
  end
end

