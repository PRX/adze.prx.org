# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :jingle,
  ecto_repos: [Jingle.Repo]

# Configures the endpoint
config :jingle, Jingle.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9Rd5cGoyH+oEwxCEhnkEbaGPAAioXhR3MeuRVn73BP47vGKeJBZ9jjGKz/xZByAK",
  render_errors: [view: Jingle.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Jingle.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures the repository
config :jingle, Jingle.Repo, adapter: Ecto.Adapters.Postgres

# Environment config (precompiled OR from env variables)
# MUST release with RELX_REPLACE_OS_VARS=true
config :jingle, :env_config,
  id_host: System.get_env("ID_HOST") || "${ID_HOST}",
  db_env_postgres_database: System.get_env("DB_ENV_POSTGRES_DATABASE") || "${DB_ENV_POSTGRES_DATABASE}",
  db_env_postgres_user: System.get_env("DB_ENV_POSTGRES_USER") || "${DB_ENV_POSTGRES_USER}",
  db_env_postgres_password: System.get_env("DB_ENV_POSTGRES_PASSWORD") || "${DB_ENV_POSTGRES_PASSWORD}",
  db_port_5432_tcp_addr: System.get_env("DB_PORT_5432_TCP_ADDR") || "${DB_PORT_5432_TCP_ADDR}",
  db_port_5432_tcp_port: System.get_env("DB_PORT_5432_TCP_PORT") || "${DB_PORT_5432_TCP_PORT}",
  db_pool_size: System.get_env("DB_POOL_SIZE") || "${DB_POOL_SIZE}"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
