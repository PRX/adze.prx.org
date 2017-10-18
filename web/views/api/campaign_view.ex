defmodule Jingle.API.CampaignView do
  use Jingle.Web, :view

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
    campaign_json(campaign, conn)
  end

  defp campaign_json(campaign, conn) do
    %{
      id: campaign.id,
      start_date: campaign.start_date,
      end_date: campaign.end_date,
      copy: campaign.copy,
      zone: campaign.zone,
      _links: %{
        self: %{
          href: api_campaign_path(conn, :show, campaign),
          templated: true
        },
        "prx:sponsor": %{
          href: api_sponsor_path(conn, :show, campaign.sponsor_id),
          templated: true
        },
        "prx:show": %{
          href: api_show_path(conn, :show, campaign.show_id),
          templated: true
        },
        "prx:creatives": %{
          href: api_campaign_creative_path(conn, :index, campaign.id),
          templated: true
        }
      }
    }
  end
end
