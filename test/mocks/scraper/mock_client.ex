defmodule NewsSearch.Scraper.MockClient do
  @moduledoc false
  @behaviour NewsSearch.Scraper.Client

  def get_html("test/one") do
    html =
      """
      <div class="article">
        <a href="test/articles/1">
          Article 1
        </a>
      </div>
      <div class="article">
        <a href="test/articles/2">
          Article 2
        </a>
      </div>
      """
    {:ok, html}
  end

  def get_html("test/two") do
    html =
      """
      <div class="article">
        <a href="test/articles/3">
          Article 3
        </a>
      </div>
      <div class="article">
        <a href="test/articles/4">
          Article 4
        </a>
      </div>
      """
    {:ok, html}
  end

  def get_html("test/three") do
    html =
      """
      <div class="article">
        <a href="test/articles/5">
          Article 5
        </a>
      </div>
      <div class="article">
        <a href="test/articles/6">
          Article 6
        </a>
      </div>
      """
    {:ok, html}
  end

  def get_html("test/articles/6"), do: {:error, :non_200}
  def get_html("test/articles/" <> num) do
    html =
      """
      <h1>Author #{num}</h1>
      <h2>Body of article #{num}</h2>

      """
    {:ok, html}
  end
end
