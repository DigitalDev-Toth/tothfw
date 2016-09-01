defmodule TothApp.AppController do
    use TothApp.Web, :controller

    def welcome(conn, params) do
        conn
        |> render(:app)
    end
end
