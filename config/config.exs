# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :news_search,
  namespace: NewsSearch,
  ecto_repos: [NewsSearch.Repo]

# Configures the endpoint
config :news_search, NewsSearchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hlyYMvGjHeRRmjOxNPBRIUwQSMCaBntjaTEc8Bjrs7Fa0FRj52xZfY/5NH8ffLRJ",
  render_errors: [view: NewsSearchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NewsSearch.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
