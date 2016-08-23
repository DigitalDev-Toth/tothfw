defmodule TothApp.ChannelCase do
    use ExUnit.CaseTemplate

    using do
        quote do
            use Phoenix.ChannelTest

            @endpoint TothApp.Endpoint
        end
    end

    setup tags do
        :ok
    end
end
