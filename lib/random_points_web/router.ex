defmodule RandomPointsWeb.Router do
  use RandomPointsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RandomPointsWeb do
    # pipe_through :api

    get "/", UserController, :index
  end
end
