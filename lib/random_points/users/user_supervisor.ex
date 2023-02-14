defmodule RandomPoints.Users.UserSupervisor do
  @moduledoc """
    This module is for user supervisor which will supervise user process
  """
  use Supervisor

  alias RandomPoints.Users.UserWorker

  @polling_time 60_000

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      {UserWorker, [name: UserWorker, poll_time: @polling_time]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def call_message(message) do
    GenServer.call(UserWorker, message)
  end
end
