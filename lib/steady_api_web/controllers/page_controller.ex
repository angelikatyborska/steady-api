defmodule SteadyAPIWeb.PageController do
  use SteadyAPIWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
