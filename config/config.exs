# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :adze,
  ecto_repos: [Adze.Repo]

# Configures the endpoint
config :adze, Adze.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9Rd5cGoyH+oEwxCEhnkEbaGPAAioXhR3MeuRVn73BP47vGKeJBZ9jjGKz/xZByAK",
  render_errors: [view: Adze.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Adze.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures the repository
config :adze, Adze.Repo,
 adapter: Ecto.Adapters.Postgres,
 database: System.get_env("DB_ENV_POSTGRES_DATABASE"),
 username: System.get_env("DB_ENV_POSTGRES_USER"),
 password: System.get_env("DB_ENV_POSTGRES_PASSWORD"),
 hostname: System.get_env("DB_PORT_5432_TCP_ADDR"),
 port: System.get_env("DB_PORT_5432_TCP_PORT"),
 pool_size: String.to_integer(System.get_env("DB_POOL_SIZE") || "2")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
