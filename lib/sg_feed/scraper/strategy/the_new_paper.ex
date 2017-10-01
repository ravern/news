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
  def attributes(:article) do
    [
      # :subtitle,
      # :highlight,
      # :body,
      # :thumbnail,
      # :image,
      # :authors,
      # :published_at,
    ]
  end

  def articles(html) do
    html
    |> Floki.find(".card")
    |> Enum.map(&Floki.raw_html/1)
  end

  def title(html) do
    html
    |> Floki.find(".card-title")
    |> Floki.text()
  end

  def thumbnail(html) do
    html
    |> Floki.find(".card-media img")
    |> Floki.attribute("src")
    |> List.first()
  end

  def permalink(html) do
    html
    |> Floki.find(".card-title a")
    |> Floki.attribute("href")
    |> List.first()
  end
end
