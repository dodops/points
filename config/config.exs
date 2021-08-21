# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :points,
  ecto_repos: [Points.Repo]

# Configures the endpoint
config :points, PointsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ig1Ja145wMW0mCyfbykJ+SlMhqRPiyyk86LUi2MXL6dkiOIcU8ABABJnN/YHUt5C",
  render_errors: [view: PointsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Points.PubSub,
  live_view: [signing_salt: "390NSHUw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
