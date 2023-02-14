defmodule RandomPointsWeb.UserControllerTest do
  use RandomPointsWeb.ConnCase
  use Mimic

  alias RandomPoints.Model.User

  describe "index/1" do
    setup %{conn: conn} do
      path = Routes.user_path(conn, :index)

      {:ok, path: path}
    end

    test "request suceeds in returning a user and a timestamp", %{conn: conn, path: path} do
      assert json_response =
               conn
               |> get(path)
               |> json_response(200)

      assert %{"timestamp" => nil, "users" => []} == json_response
    end

    test "request suceeds in returning mocked data", %{conn: conn, path: path} do
      %User{points: points1, id: id1} = user1 = insert(:user)
      %User{points: points2, id: id2} = user2 = insert(:user)

      timestamp = DateTime.utc_now()

      expect(RandomPoints.User, :get_users, fn ->
        {:ok, {[user1, user2], timestamp}}
      end)

      assert json_response =
               conn
               |> get(path)
               |> json_response(200)

      assert %{"timestamp" => _timestamp, "users" => users} = json_response
      assert [%{"points" => points1, "id" => id1}, %{"points" => points2, "id" => id2}] == users
    end
  end
end
