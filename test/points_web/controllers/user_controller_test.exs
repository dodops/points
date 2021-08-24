defmodule PointsWeb.UserControllerTest do
  use PointsWeb.ConnCase

  alias Points.Accounts

  @create_attrs %{
    points: 42
  }

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "returns a nil timestamp first time it is requested, then return the timestamp from the last request",
         %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["timestamp"] == nil

      conn = get(conn, Routes.user_path(conn, :index))
      refute json_response(conn, 200)["timestamp"] == nil
    end
  end
end
