defmodule RandomPointsWeb.UserView do
  use RandomPointsWeb, :view

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{users: render_many(users, RandomPointsWeb.UserView, "user.json"), timestamp: timestamp}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, points: user.points}
  end
end
