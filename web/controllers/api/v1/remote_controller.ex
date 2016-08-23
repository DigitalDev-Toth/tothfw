defmodule TothApp.RemoteController do
    use TothApp.Web, :controller

    plug Guardian.Plug.EnsureAuthenticated, handler: TothApp.SessionController

    def get_users(conn, _params) do
        {:ok, users} = TothApp.Looker.get_users()

        conn
        |> put_status(:created)
        |> render("show.json", users: users)
    end

    def set_user(conn, params) do
        {:ok, users} = TothApp.Looker.set_user(conn, params)

        TothApp.AppChannel.remote_users(users)

        conn
        |> put_status(:created)
        |> render("ok.json")
    end
end
