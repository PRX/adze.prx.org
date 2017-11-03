defmodule Jingle.API.PodcastView do
  use Jingle.Web, :view

  def render("index.json", %{conn: conn, podcasts: podcasts}) do
    %{
      count: length(podcasts),
      total: length(podcasts),
      _embedded: %{
        "prx:items": Enum.map(podcasts, fn(c) -> podcast_json(c, conn) end)
      },
    }
  end

  def render("show.json", %{conn: conn, podcast: podcast}) do
    campaigns = Enum.map(podcast.campaigns, fn c ->
      %{start_date: c.start_date, end_date: c.end_date}
    end)
    podcast_json(podcast, conn)
    |> Map.put(:campaigns, campaigns)
  end

  defp podcast_json(podcast, conn) do
    %{
      id: podcast.id,
      structure: podcast.structure,
      network: podcast.network,
      name: podcast.name,
      rate: podcast.rate,
      notes: podcast.notes,
      recording_day: podcast.recording_day,
      _links: %{
        self: %{
          href: api_podcast_path(conn, :show, podcast),
          templated: true
        },
        "prx:campaigns": %{
          href: api_podcast_campaign_path(conn, :index, podcast),
          templated: true
        }
      }
    }
  end
end
