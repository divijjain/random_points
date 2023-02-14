# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RandomPoints.Repo.insert!(%RandomPoints.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias RandomPoints.Model.User
alias RandomPoints.Repo

# we will insert 5000 rows under a single db query with insert_all
# spawns supervised concurrent tasks(async processes) to insert 5000 rows, each under a single db query due to postgres limitation with insert_all.
# By default, the limit max_concurrency is set to the number of logical cores available in the system or System.schedulers_online.

users_stream =
  1..1_000_000
  |> Stream.map(fn _ -> %{points: 0} end)
  |> Stream.chunk_every(5000)

{:ok, supervisor_pid} = Task.Supervisor.start_link()

supervisor_pid
|> Task.Supervisor.async_stream_nolink(
  users_stream,
  fn users ->
    Repo.insert_all(User, users)
  end
)
|> Stream.run()
