defmodule Jingle.Repo do
  use Ecto.Repo, otp_app: :jingle

   def init(_, opts) do
     {:ok, load_opts(opts, Mix.env)}
  end

  defp load_opts(opts, env) when env in [:dev, :test] do
    Dotenv.load!
    load_opts(opts, nil)
  end
  defp load_opts(opts, _env) do
    opts
    |> Keyword.put(:database, Env.get(:db_env_postgres_database))
    |> Keyword.put(:username, Env.get(:db_env_postgres_user))
    |> Keyword.put(:password, Env.get(:db_env_postgres_password))
    |> Keyword.put(:hostname, Env.get(:db_port_5432_tcp_addr))
    |> Keyword.put(:port, Env.get(:db_port_5432_tcp_port))
    |> Keyword.put(:pool_size, Env.get(:db_pool_size))
  end
end
