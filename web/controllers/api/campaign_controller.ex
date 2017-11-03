defmodule Jingle.API.CampaignController do
  use Jingle.Web, :controller

  alias Jingle.API.Campaign

  def index(conn, %{"sponsor_id" => sponsor_id}) do
    campaigns = Repo.all(from c in Campaign, where: c.sponsor_id == ^sponsor_id)
    render(conn, "index.json", campaigns: campaigns)
  end

  def index(conn, %{"podcast_id" => podcast_id}) do
    campaigns = Repo.all(from c in Campaign, where: c.podcast_id == ^podcast_id)
    render(conn, "index.json", campaigns: campaigns)
  end

  def index(conn, _params) do
    campaigns = Repo.all(Campaign)
    render(conn, "index.json", campaigns: campaigns)
  end

  def create(conn, %{"campaign" => campaign_params}) do
    changeset = Campaign.changeset(%Campaign{}, campaign_params)

    case Repo.insert(changeset) do
      {:ok, campaign} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", api_campaign_path(conn, :show, campaign))
        |> render("show.json", campaign: campaign)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jingle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    campaign = Repo.get!(Campaign, id)
    render(conn, "show.json", campaign: campaign)
  end

  def update(conn, %{"id" => id, "campaign" => campaign_params}) do
    campaign = Repo.get!(Campaign, id)
    changeset = Campaign.changeset(campaign, campaign_params)

    case Repo.update(changeset) do
      {:ok, campaign} ->
        render(conn, "show.json", campaign: campaign)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Jingle.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    campaign = Repo.get!(Campaign, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(campaign)

    send_resp(conn, :no_content, "")
  end
end
