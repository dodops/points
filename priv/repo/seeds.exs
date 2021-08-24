# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Points.Repo.insert!(%Points.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Points.Repo
alias Points.Accounts

data =
  Enum.map(1..1_000_000, fn _ -> %{points: 0} end)
  |> Enum.map(fn row ->
    now = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

    row
    |> Map.put(:inserted_at, now)
    |> Map.put(:updated_at, now)
  end)

list_of_chunks = Enum.chunk_every(data, 10_000)

Enum.each(list_of_chunks, fn rows ->
  Repo.insert_all(Accounts.User, rows)
end)
