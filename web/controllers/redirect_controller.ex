defmodule Jingle.RedirectController do
  use Jingle.Web, :controller

  import Jingle.Router.Helpers

  def index(conn, _params) do
    redirect conn, to: api_root_path(conn, :index)
  end
end
