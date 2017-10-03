defmodule NewsSearch.Scraper.MockStrategy do
  @moduledoc false
  @behaviour NewsSearch.Scraper.Strategy

  def base_url, do: "test"

  def categories do
    [
      one: "/one",
      two: "/two",
      three: "/three",
    ]
  end

  def attributes(:feed) do
    [
      :title,
    ]
  end
  def attributes(:article) do
    [
      :author,
      :body,
    ]
  end

  def articles(html) do
    html
    |> Floki.find(".article")
    |> Enum.map(&Floki.raw_html/1)
  end

  def title(html) do
    html
    |> Floki.text()
  end

  def permalink(html) do
    html
    |> Floki.find("a")
    |> Floki.attribute("href")
    |> List.first()
  end

  def author(html) do
    html
    |> Floki.find("h1")
    |> Floki.text()
  end

  def body(html) do
    html
    |> Floki.find("h2")
    |> Floki.text()
  end
end
