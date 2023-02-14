defmodule RandomPoints.Users.UserState do
  @moduledoc """
  Defines the structure of user
  """

  defstruct [:min_number, :timestamp]

  @type t :: %__MODULE__{
          min_number: integer(),
          timestamp: nil | integer()
        }

  @spec new :: RandomPoints.Users.UserState.t()
  def new do
    %__MODULE__{
      min_number: random_number(),
      timestamp: nil
    }
  end

  @spec update_min_number(RandomPoints.Users.UserState.t()) :: RandomPoints.Users.UserState.t()
  def update_min_number(%__MODULE__{} = user_state) do
    %{user_state | min_number: random_number()}
  end

  @spec update_timestamp(RandomPoints.UserState.t()) :: RandomPoints.UserState.t()
  def update_timestamp(%__MODULE__{} = user_state) do
    %{user_state | timestamp: DateTime.utc_now()}
  end

  defp random_number do
    :erlang.phash2(DateTime.utc_now(), 101)
  end
end
