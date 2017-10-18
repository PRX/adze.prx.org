defmodule Jingle.API.CreativeController do
  use Jingle.Web, :controller

  alias Jingle.API.Creative

  def index(conn, _params) do
    creatives = Repo.all(Creative)
    render(conn, "index.json", creatives: creatives)
  end

  def create(conn, %{"creative" => creative_params}) do
    changeset = Creative.changeset(%Creative{}, creative_params)

    case Repo.insert(changeset) do
      {:ok, creative} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_creative_path(conn, :show, creative))
        |> render("show.json", creative: creative)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jingle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    creative = Repo.get!(Creative, id)
    render(conn, "show.json", creative: creative)
  end

  def update(conn, %{"id" => id, "creative" => creative_params}) do
    creative = Repo.get!(Creative, id)
    changeset = Creative.changeset(creative, creative_params)

    case Repo.update(changeset) do
      {:ok, creative} ->
        render(conn, "show.json", creative: creative)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jingle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    creative = Repo.get!(Creative, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(creative)

    send_resp(conn, :no_content, "")
  end
end
