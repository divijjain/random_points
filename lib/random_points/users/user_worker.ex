defmodule RandomPoints.Users.UserWorker do
  @moduledoc """
  This module defines user worker implementation which will be supervised by user supervisor
  """

  use GenServer

  alias RandomPoints.Users.UserState
  alias RandomPoints.Users.UserRepo

  @polling_time 60_000
  @batch_size 2000

  def start_link(args) do
    opts =
      if args[:name] do
        [name: args[:name]]
      else
        []
      end

    GenServer.start_link(__MODULE__, args, opts)
  end

  def init(arg) do
    user_state = UserState.new()

    poll_time = Keyword.get(arg, :poll_time, @polling_time)

    schedule_polling(poll_time)

    {:ok, user_state}
  end

  def handle_continue({:update_users, poll_time}, user_state) do
    schedule_polling(poll_time)

    new_user_state = UserState.update_min_number(user_state)

    update_users()

    {:noreply, new_user_state}
  end

  def handle_info({:poll, poll_time}, user_state) do
    {:noreply, user_state, {:continue, {:update_users, poll_time}}}
  end

  def handle_call(:get_users, _from, user_state) do
    new_user_state = UserState.update_timestamp(user_state)

    users = UserRepo.users_above_min_number(user_state.min_number)

    {:reply, {:ok, {users, user_state.timestamp}}, new_user_state}
  end

  defp schedule_polling(poll_time) do
    Process.send_after(self(), {:poll, poll_time}, poll_time)
  end

  def update_users do
    batch_size = @batch_size

    1..1_000_000
    |> Stream.chunk_every(batch_size)
    |> Task.async_stream(fn [start_id | _] = _users ->
      UserRepo.update_users(start_id, batch_size)
    end)
    |> Stream.run()

    # NOTE for reveiwers #

    # we can check performance by
    # :timer.tc(fn -> update_users end)

    # later if the number of users is too large that the processing time could take more that 60 seconds
    # we would have to use another genserver as a message queue(acting as a consumer) to handle the update_users task.
    # so that we first complete our 1 Million user updates before starting the next update.
  end
end
