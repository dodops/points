defmodule Points.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Points.Repo

  alias Points.Accounts.User

  @doc """
  Update all users points to a random value between 1 and 100
  """
  @spec reset_all_users_points_with_random_values :: {integer(), any()}
  def reset_all_users_points_with_random_values do
    Repo.update_all(
      update(User, set: [points: fragment("floor(random() * 100)")]),
      []
    )
  end

  @doc """
  Get a limited amount of users with more points than the max_number argument.

  ## Examples

      iex> users_with_points_greater_than(10, 3)
      [%User{id: 199, points: 20}, %User{id: 12, points: 340}, %User{id: 21, points: 40}]

      iex> users_with_points_greater_than(90)
      [%User{id: 231, points: 99}, %User{id: 1, points: 94}]
  """
  @spec users_with_points_greater_than(non_neg_integer(), non_neg_integer()) :: list(User.t())
  def users_with_points_greater_than(max_number, limit \\ 2) do
    query =
      from(u in "users",
        where: u.points > ^max_number,
        select: %{id: u.id, points: u.points},
        limit: ^limit
      )

    Repo.all(query)
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs \\ %{}) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
