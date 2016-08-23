use Mix.Config

config :tothfw, TothApp.Endpoint,
    http: [port: {:system, "PORT"}],
    url: [host: "localhost", port: 80],
    cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info

import_config "prod.secret.exs"
