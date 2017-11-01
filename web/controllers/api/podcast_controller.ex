defmodule Jingle.API.PodcastController do
  use Jingle.Web, :controller

  alias Jingle.API.Podcast

  def index(conn, _params) do
    podcasts = Repo.all(Podcast)
    render(conn, "index.json", podcasts: podcasts)
  end

  def create(conn, %{"podcast" => podcast_params}) do
    changeset = Podcast.changeset(%Podcast{}, podcast_params)

    case Repo.insert(changeset) do
      {:ok, podcast} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_podcast_path(conn, :show, podcast))
        |> render("podcast.json", podcast: Repo.preload(podcast, :campaigns))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jingle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    podcast = Repo.get!(Podcast, id)
    render(conn, "podcast.json", podcast: Repo.preload(podcast, :campaigns))
  end

  def update(conn, %{"id" => id, "podcast" => podcast_params}) do
    podcast = Repo.get!(Podcast, id)
    changeset = Podcast.changeset(podcast, podcast_params)

    case Repo.update(changeset) do
      {:ok, podcast} ->
        render(conn, "podcast.json", podcast: Repo.preload(podcast, :campaigns))
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jingle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    podcast = Repo.get!(Podcast, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(podcast)

    send_resp(conn, :no_content, "")
  end
end
