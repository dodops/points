defmodule Points.UserHandler do
  @moduledoc """
  GenServer designed to handle a maximum number of points, and a timestamp of the last time it was called.
  Every minute all users points are randomized to new values between 1 and 100 and saved in the database.

  It also can be used to retrieve users from databases with more points than the max_number state.
  """
  use GenServer

  alias Points.Accounts

  @one_minute 60_000

  def start_link(opts \\ []) do
    name = Keyword.get(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, opts, name: name)
  end

  @impl true
  def init(_) do
    refresh_state()

    {:ok, {random_value(), nil}}
  end

  def users_with_points_greater_than_max_number(name \\ __MODULE__) do
    GenServer.call(name, :users_points_greater_than_max_number)
  end

  @impl true
  def handle_call(:users_points_greater_than_max_number, _, {max_number, timestamp}) do
    users = Accounts.users_with_points_greater_than(max_number)

    {:reply, {users, timestamp}, {max_number, now()}}
  end

  @impl true
  def handle_info(:refresh_max_number, {_, time}) do
    refresh_state()

    Accounts.reset_all_users_points_with_random_values()

    {:noreply, {random_value(), time}}
  end

  defp refresh_state, do: Process.send_after(self(), :refresh_max_number, @one_minute)

  defp now, do: NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

  defp random_value, do: Enum.random(1..100)
end
