defmodule Points.UserHandlerTest do
  use ExUnit.Case

  alias Points.UserHandler
  alias Points.Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Repo, {:shared, self()})

    {:ok, pid} = UserHandler.start_link(name: :tester)
    {:ok, pid: pid}
  end

  test "returns empty timestamp for the first call", %{pid: pid} do
    assert UserHandler.users_with_points_greater_than_max_number(pid) == {[], nil}
  end

  test "returns a populated timestamp after the first call", %{pid: pid} do
    assert UserHandler.users_with_points_greater_than_max_number(pid) == {[], nil}

    {[], timestamp} = UserHandler.users_with_points_greater_than_max_number(pid)

    assert timestamp
  end
end
