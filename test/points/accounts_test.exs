defmodule Points.AccountsTest do
  use Points.DataCase

  alias Points.Accounts

  describe "users" do
    alias Points.Accounts.User

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(%{points: 41})
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attributes = %{points: 37}
      assert {:ok, %User{} = user} = Accounts.create_user(valid_attributes)
      assert user.points == 37
    end

    test "create_user/1 with points greather than 100 returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{points: 190})
    end

    test "create_user/1 with points less than 0 returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(%{points: -25})
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
