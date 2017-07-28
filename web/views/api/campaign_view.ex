defmodule Adze.API.CampaignView do
  use Adze.Web, :view

  def render("index.json", %{campaigns: campaigns}) do
    %{data: render_many(campaigns, Adze.API.CampaignView, "campaign.json")}
  end

  def render("show.json", %{campaign: campaign}) do
    %{data: render_one(campaign, Adze.API.CampaignView, "campaign.json")}
  end

  def render("campaign.json", %{campaign: campaign}) do
    %{id: campaign.id,
      sponsor_id: campaign.sponsor_id,
      show_id: campaign.show_id,
      start_date: campaign.start_date,
      end_date: campaign.end_date,
      copy: campaign.copy,
      zone: campaign.zone,
      repeat_sponsor: campaign.repeat_sponsor}
  end
end
