defmodule Jingle.API.SponsorController do
  use Jingle.Web, :controller

  alias Jingle.API.Sponsor

  def index(conn, _params) do
    sponsors = Repo.all(Sponsor)
    render(conn, "index.json", sponsors: sponsors)
  end

  def create(conn, %{"sponsor" => sponsor_params}) do
    changeset = Sponsor.changeset(%Sponsor{}, sponsor_params)

    case Repo.insert(changeset) do
      {:ok, sponsor} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_sponsor_path(conn, :show, sponsor))
        |> render("podcast.json", sponsor: Repo.preload(sponsor, :campaigns))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jingle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sponsor = Repo.get!(Sponsor, id)
    render(conn, "podcast.json", sponsor: Repo.preload(sponsor, :campaigns))
  end

  def update(conn, %{"id" => id, "sponsor" => sponsor_params}) do
    sponsor = Repo.get!(Sponsor, id)
    changeset = Sponsor.changeset(sponsor, sponsor_params)

    case Repo.update(changeset) do
      {:ok, sponsor} ->
        render(conn, "podcast.json", sponsor: Repo.preload(sponsor, :campaigns))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jingle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sponsor = Repo.get!(Sponsor, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sponsor)

    send_resp(conn, :no_content, "")
  end
end
