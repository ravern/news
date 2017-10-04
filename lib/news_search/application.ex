defmodule NewsSearch.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Store supervisor, which will manage the Mongo server, etc.
      supervisor(NewsSearch.Store, []),
      # Start the endpoint when the application starts
      supervisor(NewsSearchWeb.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: NewsSearch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NewsSearchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
