defmodule Jingle.API.RootController do
  use Jingle.Web, :controller

  def index(conn, _params) do
    render conn, "index.json", conn: conn
  end
end
