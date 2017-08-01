defmodule Adze.API.SponsorView do
  use Adze.Web, :view

  def render("index.json", %{conn: conn, sponsors: sponsors}) do
    %{
      count: length(sponsors),
      total: length(sponsors),
      _embedded: %{
        "prx:items": Enum.map(sponsors, fn(s) -> sponsor_json(s, conn) end)
      },
    }
  end

  def render("show.json", %{conn: conn, sponsor: sponsor}) do
    campaigns = Enum.map(sponsor.campaigns, fn c ->
      %{start_date: c.start_date, end_date: c.end_date}
    end)
    sponsor_json(sponsor, conn)
    |> Map.put(:campaigns, campaigns)
  end

  defp sponsor_json(sponsor, conn) do
    %{
      id: sponsor.id,
      name: sponsor.name,
      billing_info: sponsor.billing_info,
      notes: sponsor.notes,
      _links: %{
        self: %{
          href: api_sponsor_path(conn, :show, sponsor),
          templated: true
        },
        "prx:campaigns": %{
          href: api_sponsor_campaign_path(conn, :index, sponsor),
          templated: true
        }
      }
    }
  end

end
