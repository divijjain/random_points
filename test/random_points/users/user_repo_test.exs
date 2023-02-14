defmodule RandomPoints.Users.UserRepoTest do
  use RandomPoints.DataCase

  alias RandomPoints.Model.User
  alias RandomPoints.Repo
  alias RandomPoints.Users.UserRepo

  describe "users_above_min_number/1" do
    test "returns users above min number" do
      insert_list(3, :user, points: 5)
      insert_list(2, :user, points: 10)

      assert users = UserRepo.users_above_min_number(6)
      assert length(users) == 2
    end
  end

  describe "update_users/2" do
    test "updates users" do
      [%User{id: id, points: old_points} | _] = insert_list(10, :user, points: 5)

      assert {5, nil} == UserRepo.update_users(id, 5)

      assert %User{points: new_points} = Repo.get(User, id)

      assert new_points != old_points
    end
  end
end
