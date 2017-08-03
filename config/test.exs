use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :adze, Adze.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :adze, Adze.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: System.get_env("DB_ENV_POSTGRES_DATABASE"),
  username: System.get_env("DB_ENV_POSTGRES_USER"),
  password: System.get_env("DB_ENV_POSTGRES_PASSWORD"),
  hostname: System.get_env("DB_PORT_5432_TCP_ADDR"),
  pool: Ecto.Adapters.SQL.Sandbox
