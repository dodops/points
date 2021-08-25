defmodule PointsWeb.UserView do
  use PointsWeb, :view
  alias PointsWeb.UserView

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{
      users: render_many(users, UserView, "user.json"),
      timestamp: stringify_timestamp(timestamp)
    }
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, points: user.points}
  end

  defp stringify_timestamp(timestamp) when is_nil(timestamp), do: nil
  defp stringify_timestamp(timestamp), do: NaiveDateTime.to_string(timestamp)
end
