defmodule TothApp.ConnCase do
    use ExUnit.CaseTemplate

    using do
        quote do
            use Phoenix.ConnTest

            import TothApp.Router.Helpers

            @endpoint TothApp.Endpoint
        end
    end

    setup tags do
        {:ok, conn: Phoenix.ConnTest.conn()}
    end
end
