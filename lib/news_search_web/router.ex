defmodule NewsSearchWeb.Router do
  use NewsSearchWeb, :router

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

  scope "/", NewsSearchWeb do
    pipe_through :browser # Use the default browser stack

    get "/", SearchController, :new
    get "/search", SearchController, :index
  end
end
