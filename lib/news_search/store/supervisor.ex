defmodule NewsSearch.Store.Supervisor do
  @moduledoc """
  Supervisor module that manages the store.
  """

  use Supervisor

  @doc false
  def start_link do
    opts = Application.get_env(:news_search, :store)
    database = opts[:database] || raise "No database name given."

    children = [
      # Database driver
      worker(Mongo, [[name: :mongo, database: database, pool: DBConnection.Poolboy]]),
      # GenServer to interact with the store
      worker(NewsSearch.Store, []),
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(__MODULE__, children, opts)
  end
end
