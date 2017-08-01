defmodule Adze.API.CampaignView do
  use Adze.Web, :view

  def render("index.json", %{conn: conn, campaigns: campaigns}) do
    %{
      count: length(campaigns),
      total: length(campaigns),
      _embedded: %{
        "prx:items": Enum.map(campaigns, fn(c) -> campaign_json(c, conn) end)
      },
    }
  end

  def render("show.json", %{conn: conn, campaign: campaign}) do
    sponsor = Enum.map(campaign.sponsor, fn s ->
      %{name: s.name, notes: s.notes}
    end)
    campaign_json(campaign, conn)
    |> Map.put(:sponsor, sponsor)
  end

  defp campaign_json(campaign, conn) do
    %{
      id: campaign.id,
      sponsor_id: campaign.sponsor_id,
      show_id: campaign.show_id,
      start_date: campaign.start_date,
      end_date: campaign.end_date,
      copy: campaign.copy,
      zone: campaign.zone,
      repeat_sponsor: campaign.repeat_sponsor,
      _links: %{
        self: %{
          href: api_campaign_path(conn, :show, campaign),
          templated: true
        },
        "prx:sponsor": %{
          href: api_sponsor_path(conn, :index, campaign.sponsor),
          templated: true
        }
      }
    }
  end
end
