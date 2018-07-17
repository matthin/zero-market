defmodule ZeroMarketWeb.Router do
  use ZeroMarketWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug ZeroMarket.CurrentUser
  end

  scope "/", ZeroMarketWeb do
    pipe_through [:browser, :with_session]

    get "/", PageController, :index
    resources "/users", UserController
    resources "/products", ProductController

    get "/sign_in", SessionController, :new
    post "/sign_in", SessionController, :create
    # probably should switch to using a form + POST
    get "/sign_out", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", ZeroMarketWeb do
  #   pipe_through :api
  # end
end
