Points API
===========

[![Elixir CI](https://github.com/dodops/points/actions/workflows/elixir.yml/badge.svg)](https://github.com/dodops/points/actions/workflows/elixir.yml)

A phoenix API app, with a single endpoint. This app will return, at max 2 (it can return less), users with more than a random number of points.

## To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).


## API
Even though the setup creates 1 million users, the api returns at most two users, their points,
and the timestamp from when the last request was made.

Request:

```bash
curl -X GET http://localhost:4000/ -H 'Content-Type: application/json'
```

Response:

```json
{
  "timestamp": "2021-08-25 15:15:56",
  "users":[
    {
      "id":539805,
      "points":92
    },
    {
      "id":539813,
      "points":86
    }
  ]
}
```

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
