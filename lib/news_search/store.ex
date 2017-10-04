defmodule NewsSearch.Store do
  @moduledoc """
  Use this module to interact with the MongoDB database.
  """

  use GenServer

  @doc false
  def start_link do
    GenServer.start_link(__MODULE__, :placeholder, name: __MODULE__)
  end
end
