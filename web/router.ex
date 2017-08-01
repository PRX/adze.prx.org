defmodule Adze.Router do
  use Adze.Web, :router

  # pipeline :browser do
  #   plug :accepts, ["html"]
  #   plug :fetch_session
  #   plug :fetch_flash
  #   plug :protect_from_forgery
  #   plug :put_secure_browser_headers
  # end

  pipeline :api do
    plug :accepts, ["json", "hal"]
  end

  # pipeline :authorized do
  #   plug PrxAuth.Plug, required: true
  # end

  scope "/", Adze do
    pipe_through :api

    get "/", RedirectController, :index
    get "/api", RedirectController, :index
    get "/api/v1", API.RootController, :index, as: :api_root
  end

  scope "/api/v1", Adze.API, as: :api do
    pipe_through :api
    # pipe_through :authorized

    resources "/sponsors", SponsorController, except: [:new, :edit] do
      resources "/campaigns", CampaignController, only: [:index]
    end
    resources "/shows", ShowController, except: [:new, :edit] do
      resources "/campaigns", CampaignController, only: [:index]
    end
    resources "/campaigns", CampaignController, except: [:new, :edit]

    # resources "/creatives", CreativeController, except: [:new, :edit]
  end

end
