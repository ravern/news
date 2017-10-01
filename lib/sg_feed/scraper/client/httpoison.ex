defmodule SGFeed.Scraper.Client.HTTPoison do
  @moduledoc false

  use SGFeed.Scraper.Client

  def get_html(url) do
    # TLS v1.2 thing because of known issue
    # https://bugs.erlang.org/browse/ERL-192
    case HTTPoison.get(url, [], [ssl: [{:versions, [:'tlsv1.2']}]]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, _} ->
        {:error, :non_200}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
