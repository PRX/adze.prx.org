defmodule Adze.API.SponsorView do
  use Adze.Web, :view

  def render("index.json", %{sponsors: sponsors}) do
    %{data: render_many(sponsors, Adze.API.SponsorView, "sponsor.json")}
  end

  def render("show.json", %{sponsor: sponsor}) do
    %{data: render_one(sponsor, Adze.API.SponsorView, "sponsor.json")}
  end

  def render("sponsor.json", %{sponsor: sponsor}) do
    %{id: sponsor.id,
      name: sponsor.name,
      billing_info: sponsor.billing_info,
      notes: sponsor.notes}
  end
end
