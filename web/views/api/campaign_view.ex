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
      startDate: iso_8601_date_format(campaign.start_date),
      endDate: iso_8601_date_format(campaign.end_date),
      dueDate: iso_8601_date_format(campaign.due_date),
      updatedAt: iso_8601_date_format(campaign.updated_at),
      originalCopy: campaign.original_copy,
      editedCopy: campaign.edited_copy,
      mustSay: campaign.must_say,
      notes: campaign.notes,
      approved: campaign.approved,
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
        "prx:podcast": %{
          href: api_podcast_path(conn, :show, campaign.podcast_id),
          templated: true
        },
        "prx:creatives": %{
          href: api_campaign_creative_path(conn, :index, campaign.id),
          templated: true
        }
      }
    }
  end

  defp iso_8601_date_format(date) do
    Timex.format!(Ecto.DateTime.cast!(date), "{ISO:Extended:Z}")
  end
end
