defmodule RandomPoints.Users.UserWorkerTest do
  use RandomPoints.DataCase

  alias RandomPoints.Users.{UserState, UserWorker}

  describe "start_link/1" do
    test "successfully starts GenServer" do
      assert {:ok, pid} = UserWorker.start_link([])
      assert is_pid(pid)
    end
  end

  describe "genserver flow" do
    test "init succeeds" do
      pid = start_supervised!({UserWorker, []})

      assert %UserState{} = :sys.get_state(pid)
    end

    test "test for polling" do
      pid = start_supervised!({UserWorker, [poll_time: 1000]})

      assert %UserState{min_number: min_number} = :sys.get_state(pid)

      Process.sleep(1000)

      assert %UserState{min_number: new_min_number} = :sys.get_state(pid)

      assert new_min_number != min_number
    end

    test "test for get_users" do
      pid = start_supervised!({UserWorker, [poll_time: 1000]})

      assert {:ok, {users, timestamp}} = GenServer.call(pid, :get_users)

      assert is_list(users)
      assert timestamp == nil

      assert {:ok, {_users, timestamp_2}} = GenServer.call(pid, :get_users)

      assert timestamp_2 != nil
    end
  end
end
