require IEx

defmodule Adze.API.ShowView do
  use Adze.Web, :view

  def render("index.json", %{conn: conn, shows: shows}) do
    %{
      count: length(shows),
      total: length(shows),
      _embedded: %{
        "prx:items": Enum.map(shows, fn(c) -> show_json(c, conn) end)
      },
    }
  end

  def render("show.json", %{conn: conn, show: show}) do
    campaigns = Enum.map(show.campaigns, fn c ->
      %{start_date: c.start_date, end_date: c.end_date}
    end)
    show_json(show, conn)
    |> Map.put(:campaigns, campaigns)
  end

  defp show_json(show, conn) do
    %{
      id: show.id,
      structure: show.structure,
      network: show.network,
      name: show.name,
      rate: show.rate,
      notes: show.notes,
      recording_day: show.recording_day,
      _links: %{
        self: %{
          href: api_show_path(conn, :show, show),
          templated: true
        },
        "prx:campaigns": %{
          href: api_show_campaign_path(conn, :index, show),
          templated: true
        }
      }
    }
  end
end
