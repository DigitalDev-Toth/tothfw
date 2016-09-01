defmodule TothApp.Router do
    use TothApp.Web, :router

    pipeline :browser do
        plug :accepts, ["html"]
        plug :fetch_session
        plug :fetch_flash
        plug :protect_from_forgery
        plug :put_secure_browser_headers
    end

    pipeline :api do
        plug :accepts, ["json"]
        plug Guardian.Plug.VerifyHeader
        plug Guardian.Plug.LoadResource
    end

    scope "/", TothApp do
        pipe_through :browser

        get     "/", AppController, :welcome
        get     "/welcome", AppController, :welcome
    end

    scope "/api", TothApp do
        pipe_through :api

        scope "/v1" do
            post    "/auth/sessions", SessionController, :create
            delete  "/auth/sessions", SessionController, :delete
            post    "/message/welcome", MessageController, :welcome
            post    "/message/entered", MessageController, :entered
            post    "/remote/get_users", RemoteController, :get_users
            post    "/remote/set_user", RemoteController, :set_user
        end
    end
end
