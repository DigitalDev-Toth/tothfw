defmodule TothApp.AppController do
    use TothApp.Web, :controller

    def index(conn, params) do
        conn
        |> render(:app)
    end
end
