defmodule RandomPoints.Model.User do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  @required_params ~w(points)a

  @type t :: %__MODULE__{
          points: integer(),
          inserted_at: DateTime.t(),
          updated_at: DateTime.t()
        }

  schema "users" do
    field :points, :integer
    timestamps()
  end

  def changeset(user \\ %User{}, params)

  def changeset(user, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_number(:points, greater_than_or_equal_to: 0)
    |> validate_number(:points, less_than_or_equal_to: 100)
  end
end
