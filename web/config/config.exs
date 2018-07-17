# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :zero_market,
  ecto_repos: [ZeroMarket.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :zero_market, ZeroMarketWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("ENDPOINT_SECRET"),
  render_errors: [view: ZeroMarketWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ZeroMarket.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :guardian, Guardian,
  issuer: "ZeroMarket",
  ttl: { 1, :days },
  allowed_drift: 2000,
  secret_key: System.get_env("GUARDIAN_SECRET"),
  serializer: ZeroMarket.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
