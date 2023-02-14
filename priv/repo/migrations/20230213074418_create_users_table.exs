defmodule RandomPoints.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer

      timestamps(
        type: :utc_datetime_usec,
        default: fragment("timezone('utc', now())")
      )
    end
  end
end
