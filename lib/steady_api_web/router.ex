defmodule SteadyAPIWeb.Router do
  use SteadyAPIWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SteadyAPIWeb do
    pipe_through :api

    get "/earnings", EarningsController, :index
  end
end
