defmodule Adze.API.RootController do
  use Adze.Web, :controller

  def index(conn, _params) do
    render conn, "index.json", conn: conn
  end
end
