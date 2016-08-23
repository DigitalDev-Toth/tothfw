use Mix.Config

config :tothfw, TothApp.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn
