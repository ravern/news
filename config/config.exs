# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :sg_feed,
  namespace: SGFeed,
  ecto_repos: [SGFeed.Repo]

# Configures the endpoint
config :sg_feed, SGFeedWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hlyYMvGjHeRRmjOxNPBRIUwQSMCaBntjaTEc8Bjrs7Fa0FRj52xZfY/5NH8ffLRJ",
  render_errors: [view: SGFeedWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: SGFeed.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
