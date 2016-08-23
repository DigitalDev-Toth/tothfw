defmodule TothApp.Looker do

    def set_user(conn, params) do
        id = params["id"]
        username = params["username"]
        name = params["name"]
        ip = Enum.join(Tuple.to_list(conn.remote_ip), ".")
        agent = Enum.at(Tuple.to_list(List.keyfind(conn.req_headers, "user-agent", 0)), 1)

        TothApp.RemoteUsers.new_user(id, %{
            id: id,
            username: username,
            name: name,
            ip: ip,
            agent: agent
        })
        users = TothApp.RemoteUsers.get_users()
        |> parse_users

        {:ok, users}
    end

    def get_users() do
        users = TothApp.RemoteUsers.get_users()
        |> parse_users

        {:ok, users}
    end

    def delete_user(key) do
        TothApp.RemoteUsers.delete_user(key)

        users = TothApp.RemoteUsers.get_users()
        |> parse_users


        {:ok, users}
    end

    defp parse_users(users) do
        data = for user <- users do
            Enum.at(Enum.at(Tuple.to_list(user), 1), 0)
        end

        data
    end
end
