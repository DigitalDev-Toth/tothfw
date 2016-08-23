use Mix.Config

config :tothfw, TothApp.Endpoint,
    url: [host: "localhost"],
    root: Path.dirname(__DIR__),
    secret_key_base: "apbxuUZdFQo73oqIXsx9iresK+ggfKKeGp3d1JbDX8YZIcfTUgixsb9+Y6JKYC1k",
    render_errors: [accepts: ~w(html json)],
    pubsub: [name: TothApp.PubSub,
            adapter: Phoenix.PubSub.PG2]

config :logger, :console,
    format: "$time $metadata[$level] $message\n",
    metadata: [:request_id]

config :guardian, Guardian,
    issuer: "TothApp",
    ttl: {3, :days},
    verify_issuer: true,
    serializer: TothApp.GuardianSerializer,
    secret_key: "apbxuUZdFQo73oqIXsx9iresK+ggfKKeGp3d1JbDX8YZIcfTUgixsb9+Y6JKYC1k"

import_config "#{Mix.env}.exs"
