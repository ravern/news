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
      racing: "/racing", ]
  end

  def attributes(:feed) do
    [
      :title,
      :thumbnail,
    ]
  end
  def attributes(:article) do
    [
      :highlight,
      :body,
      :image,
      :author,
      :published_at,
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

  def highlight(html) do
    html
    |> Floki.find(".body-copy .lead")
    |> Floki.text()
  end

  def body(html) do
    html
    |> Floki.find(".body-copy")
    |> Floki.filter_out(".lead")
    |> Floki.find("p")
    |> Enum.map(&Floki.text/1)
    |> Enum.join("\n\n")
  end

  def image(html) do
    html
    |> Floki.find(".media-group img")
    |> Floki.attribute("src")
    |> List.first()
  end

  def author(html) do
    html
    |> Floki.find(".byline-block-with-photo")
    |> Floki.filter_out(".report-details")
    |> Floki.filter_out(".byline-designation")
    |> Floki.text()
  end

  def published_at(html) do
    published_at =
      html
      |> Floki.find(".byline-block-with-photo .report-details .story--published-date")
      |> Floki.text()
      |> Timex.parse("%b %d, %Y %I:%M %p", :strftime)

    case published_at do
      {:error, _} -> nil
      {:ok, published_at} -> published_at
    end
  end
end
