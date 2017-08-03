defmodule Adze.API.ShowController do
  use Adze.Web, :controller

  alias Adze.API.Show

  def index(conn, _params) do
    shows = Repo.all(Show)
    render(conn, "index.json", shows: shows)
  end

  def create(conn, %{"show" => show_params}) do
    changeset = Show.changeset(%Show{}, show_params)

    case Repo.insert(changeset) do
      {:ok, show} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_show_path(conn, :show, show))
        |> render("show.json", show: Repo.preload(show, :campaigns))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Adze.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    show = Repo.get!(Show, id)
    render(conn, "show.json", show: Repo.preload(show, :campaigns))
  end

  def update(conn, %{"id" => id, "show" => show_params}) do
    show = Repo.get!(Show, id)
    changeset = Show.changeset(show, show_params)

    case Repo.update(changeset) do
      {:ok, show} ->
        render(conn, "show.json", show: Repo.preload(show, :campaigns))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Adze.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    show = Repo.get!(Show, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(show)

    send_resp(conn, :no_content, "")
  end
end
