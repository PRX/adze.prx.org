defmodule Jingle.API.RootView do
  use Jingle.Web, :view

  def render("index.json", %{conn: conn}) do
    %{
      version: "v1",
      _links: %{
        self: %{
          href: api_root_path(conn, :index),
          profile: "http://meta.prx.org/model/api",
        },
        profile: %{
          href: "http://meta.prx.org/model/api",
        },
        "prx:campaigns": [%{
          title: "Get a paged collection of sponsorship campaigns",
          profile: "http://meta.prx.org/model/campaign",
          href: api_campaign_path(conn, :index) <> "{?page,per}",
          templated: true,
        }],
        "prx:campaign": [%{
          title: "Get info for a single campaign",
          profile: "http://meta.prx.org/model/campaign",
          href: fix_path(api_campaign_path(conn, :show, "{id}")),
          templated: true,
        }],
        "prx:podcasts": [%{
          title: "Get a paged collection of podcasts",
          profile: "http://meta.prx.org/model/podcast",
          href: api_podcast_path(conn, :index) <> "{?page,per}",
          templated: true,
        }],
        "prx:podcast": [%{
          title: "Get info for a single podcast",
          profile: "http://meta.prx.org/model/podcast",
          href: fix_path(api_podcast_path(conn, :show, "{id}")),
          templated: true,
        }],
        "prx:sponsors": [%{
          title: "Get a paged collection of sponsors",
          profile: "http://meta.prx.org/model/sponsor",
          href: api_sponsor_path(conn, :index) <> "{?page,per}",
          templated: true,
        }],
        "prx:sponsor": [%{
          title: "Get info for a single sponsor",
          profile: "http://meta.prx.org/model/sponsor",
          href: fix_path(api_sponsor_path(conn, :show, "{id}")),
          templated: true,
        }],
        "prx:creatives": [%{
          title: "Get a paged collection of creatives",
          profile: "http://meta.prx.org/model/creative",
          href: api_creative_path(conn, :index) <> "{?page,per}",
          templated: true,
        }],
        "prx:creative": [%{
          title: "Get info for a single creative",
          profile: "http://meta.prx.org/model/creative",
          href: fix_path(api_creative_path(conn, :show, "{id}")),
          templated: true,
        }],

      }
    }
  end

  defp fix_path(path) do
    path |> String.replace("%7B", "{") |> String.replace("%7D", "}")
  end

end
