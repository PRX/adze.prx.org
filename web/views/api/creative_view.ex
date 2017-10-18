defmodule Jingle.API.CreativeView do
  use Jingle.Web, :view

  def render("index.json", %{conn: conn, creatives: creatives}) do
    %{
      count: length(creatives),
      total: length(creatives),
      _embedded: %{
        "prx:items": Enum.map(creatives, fn(c) -> creative_json(c, conn) end)
      }
    }
  end

  def render("show.json", %{conn: conn, creative: creative}) do
    creative_json(creative, conn)
  end

  defp creative_json(creative, conn) do
    %{
      id: creative.id,
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
      format: creative.format,
      _links: %{
        self: %{
          href: api_creative_path(conn, :show, creative),
          templated: true
        },
        "prx:campaign": %{
          href: api_campaign_path(conn, :show, creative.campaign_id),
          templated: true
        }
      }
    }
  end
end
