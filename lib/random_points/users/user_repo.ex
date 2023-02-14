defmodule RandomPoints.Users.UserRepo do
  @moduledoc """
    This module is for user Repo interactions
  """
  import Ecto.Query

  alias RandomPoints.Repo
  alias RandomPoints.Model.User

  @spec users_above_min_number(integer()) :: [User.t() | nil | term()]
  def users_above_min_number(min_points) do
    from(u in User, where: u.points >= ^min_points, limit: 2)
    |> Repo.all()
  end

  def update_users(start_id, batch_size) do
    end_id = start_id + batch_size

    from(u in User, where: u.id >= ^start_id and u.id < ^end_id)
    |> update(set: [points: fragment("floor(random()*100)")])
    |> Repo.update_all([])
  end
end
