defmodule TothApp.MessageController do
    use TothApp.Web, :controller

    plug Guardian.Plug.EnsureAuthenticated, handler: TothApp.SessionController

    def welcome(conn, params) do
        id = params["id"]
        name = params["name"]
        message = "Bienvenido #{name}"

        TothApp.AppChannel.welcome(id, message)

        conn
        |> put_status(:created)
        |> render("show.json")
    end

    def entered(conn, params) do
        id = params["id"]
        name = params["name"]
        message = "#{name} ha ingresado"

        TothApp.AppChannel.entered(id, message)

        conn
        |> put_status(:created)
        |> render("show.json")
    end
end
