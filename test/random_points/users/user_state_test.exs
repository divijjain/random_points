defmodule RandomPoints.Users.UserStateTest do
  use RandomPoints.DataCase

  alias RandomPoints.Users.UserState

  describe "new/0" do
    test "returns a new user state" do
      assert %UserState{min_number: min_number, timestamp: nil} = UserState.new()
      assert is_integer(min_number)
    end

    test "updates the min_number" do
      user_state = UserState.new()

      assert new_user_state = UserState.update_min_number(user_state)
      assert new_user_state.min_number != user_state.min_number
    end

    test "updates timestamp" do
      user_state = UserState.new()

      assert new_user_state = UserState.update_timestamp(user_state)
      assert new_user_state.timestamp != user_state.timestamp
    end
  end
end
