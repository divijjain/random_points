defmodule RandomPointsWeb.UserController do
  use RandomPointsWeb, :controller

  alias RandomPoints.User

  def index(conn, _params) do
    case User.get_users() do
      {:ok, {users, timestamp}} ->
        render(conn, "index.json", users: users, timestamp: timestamp)

      _ ->
        conn
        |> put_status(503)
        |> json(%{error: "server down Please try again later."})
    end
  end
end
