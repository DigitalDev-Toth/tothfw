use Mix.Config

config :tothfw, TothApp.Endpoint,
    http: [port: 4000],
    debug_errors: true,
    code_reloader: true,
    check_origin: false,
    watchers: [node: ["node_modules/webpack/bin/webpack.js", "--watch-stdin", "--progress", "--colors"]]

config :tothfw, TothApp.Endpoint,
    live_reload: [
        patterns: [
            ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
            ~r{priv/gettext/.*(po)$},
            ~r{web/views/.*(ex)$},
            ~r{web/templates/.*(eex)$}
        ]
    ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20
