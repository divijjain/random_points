defmodule RandomPoints.Factory do
  @moduledoc """
  Factories for RandomPoints
  """
  use ExMachina.Ecto, repo: RandomPoints.Repo

  def user_factory do
    %RandomPoints.Model.User{
      points: 0
    }
  end
end
