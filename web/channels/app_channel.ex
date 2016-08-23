defmodule TothApp.AppChannel do
    use Phoenix.Channel

    def join("module:index", payload, socket) do
        socket = assign(socket, :key, payload["key"])

        {:ok, socket}
    end

    def join("module:looker", _payload, socket) do
        {:ok, socket}
    end

    def welcome(id, message) do
        TothApp.Endpoint.broadcast!(
            "module:index",
            "welcome__#{id}",
            %{id: id, message: message})
    end

    def entered(id, message) do
        TothApp.Endpoint.broadcast!(
            "module:index",
            "entered",
            %{id: id, message: message})
    end

    def remote_users(users) do
        TothApp.Endpoint.broadcast!(
            "module:looker",
            "remote_users",
            %{users: users})
    end

    def terminate(_reason, socket) do
        topic = socket.topic

        if topic == "module:index" do
            key = socket.assigns.key

            {:ok, users} = TothApp.Looker.delete_user(key)

            TothApp.AppChannel.remote_users(users)
        end

        :ok
    end
end
