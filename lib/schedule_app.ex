defmodule TothApp do
    use Application

    def start(_type, _args) do
        import Supervisor.Spec, warn: false

        children = [
            supervisor(TothApp.Endpoint, []),

            worker(TothApp.RemoteUsers, [[name: :remote_users]]),
        ]

        opts = [strategy: :one_for_one, name: TothApp.Supervisor]
        Supervisor.start_link(children, opts)
    end

    def config_change(changed, _new, removed) do
        TothApp.Endpoint.config_change(changed, removed)
        :ok
    end
end
