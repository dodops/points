defmodule Points.Accounts.User do
  @moduledoc """
  Represents a User inside Accounts context
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{
          points: non_neg_integer()
        }

  schema "users" do
    field :points, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_required([:points])
    |> check_constraint(:points, name: :points_range, message: "points must be between 0 and 100")
  end
end
