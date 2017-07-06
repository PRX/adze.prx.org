defmodule Adze.RedirectController do
  use Adze.Web, :controller

  import Adze.Router.Helpers

  def index(conn, _params) do
    redirect conn, to: api_root_path(conn, :index)
  end
end
