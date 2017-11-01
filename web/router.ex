defmodule Jingle.Router do
  use Jingle.Web, :router

  pipeline :api do
    plug :accepts, ["json", "hal"]
  end

  def id_host, do: Env.get(:id_host)
  pipeline :authorized do
    plug PrxAuth.Plug, required: true, iss: &Jingle.Router.id_host/0
  end

  scope "/", Jingle do
    pipe_through :api

    get "/", RedirectController, :index
    get "/api", RedirectController, :index
    get "/api/v1", API.RootController, :index, as: :api_root
  end

  scope "/api/v1", Jingle.API, as: :api do
    pipe_through :api
    # pipe_through :authorized

    resources "/sponsors", SponsorController, except: [:new, :edit] do
      resources "/campaigns", CampaignController, only: [:index]
    end

    resources "/podcasts", PodcastController, except: [:new, :edit] do
      resources "/campaigns", CampaignController, only: [:index]
    end

    resources "/campaigns", CampaignController, except: [:new, :edit] do
      resources "/creatives", CreativeController, except: [:new, :edit]
    end

    resources "/creatives", CreativeController, except: [:new, :edit]

  end

end
