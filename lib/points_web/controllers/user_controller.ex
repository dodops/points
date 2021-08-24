defmodule PointsWeb.UserController do
  use PointsWeb, :controller

  alias Points.UserHandler

  action_fallback PointsWeb.FallbackController

  def index(conn, _params) do
    {users, timestamp} = UserHandler.users_with_points_greater_than_max_number()
    render(conn, "index.json", users: users, timestamp: timestamp)
  end
end
