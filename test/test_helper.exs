{:ok, _} = Application.ensure_all_started(:ex_machina)
Mimic.copy(RandomPoints.User)
ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(RandomPoints.Repo, :manual)
