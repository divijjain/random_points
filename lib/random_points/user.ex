defmodule RandomPoints.User do
  @moduledoc """
  This module is user to interact with the user process
  """

  alias RandomPoints.Users.UserSupervisor
  alias RandomPoints.Model.User

  @doc """
  This function returns the users with points greater that min_points and
  the last timestamp from the user process.
  """
  @spec get_users :: {:ok, {list(User.t()), DateTime.t()}}
  def get_users do
    UserSupervisor.call_message(:get_users)
  end
end
