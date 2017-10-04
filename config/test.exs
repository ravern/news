use Mix.Config

# Configure the name of the MongoDB database
config :news_search, :store,
  database: "news_search_test"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :news_search, NewsSearchWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
