defmodule Jingle.API.CreativeView do
  use Jingle.Web, :view

  def render("index.json", %{creatives: creatives}) do
    %{data: render_many(creatives, Jingle.CreativeView, "creative.json")}
  end

  def render("show.json", %{creative: creative}) do
    %{data: render_one(creative, Jingle.CreativeView, "creative.json")}
  end

  def render("creative.json", %{creative: creative}) do
    %{id: creative.id,
      status: creative.status,
      filename: creative.filename,
      zone: creative.zone,
      size: creative.size,
      content_type: creative.content_type,
      label: creative.label,
      length: creative.length,
      layer: creative.layer,
      bit_rate: creative.bit_rate,
      duration: creative.duration,
      channel_mode: creative.channel_mode,
      upload_path: creative.upload_path,
      format: creative.format}
  end
end
