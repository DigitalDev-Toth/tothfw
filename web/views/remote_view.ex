defmodule TothApp.RemoteView do
    use TothApp.Web, :view

    def render("show.json", %{users: users}) do
        %{users: users}
    end

    def render("ok.json", _) do
        %{ok: true}
    end

    def render("error.json", _) do
        %{error: "invalid users"}
    end
end
