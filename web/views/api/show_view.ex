defmodule Adze.API.ShowView do
  use Adze.Web, :view

  def render("index.json", %{shows: shows}) do
    %{data: render_many(shows, Adze.API.ShowView, "show.json")}
  end

  def render("show.json", %{show: show}) do
    %{data: render_one(show, Adze.API.ShowView, "show.json")}
  end

  def render("show.json", %{show: show}) do
    %{id: show.id,
      structure: show.structure,
      network: show.network,
      name: show.name,
      rate: show.rate,
      notes: show.notes,
      recording_day: show.recording_day}
  end
end
