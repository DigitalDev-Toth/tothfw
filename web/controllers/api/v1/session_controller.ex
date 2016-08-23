defmodule TothApp.SessionController do
    use TothApp.Web, :controller

    plug :scrub_params, "session" when action in [:create]

    def create(conn, %{"session" => session}) do
        case TothApp.Session.authenticate(session) do
            {:ok, user} ->
                {:ok, token, _full_claims} = Guardian.encode_and_sign(user["_id"], :token)

                if user["role"] == 0 do
                    {:ok, admin, _full_claims} = Guardian.encode_and_sign(token, :token)

                    conn
                    |> put_status(:created)
                    |> render("admin.json", token: token, admin: admin, user: user)
                else
                    conn
                    |> put_status(:created)
                    |> render("show.json", token: token, user: user)
                end
            :error ->
                conn
                |> put_status(:unprocessable_entity)
                |> render("error.json")
        end
    end

    def delete(conn, _) do
        {:ok, claims} = Guardian.Plug.claims(conn)

        conn
        |> Guardian.Plug.current_token
        |> Guardian.revoke!(claims)

        conn
        |> render("delete.json")
    end

    def unauthenticated(conn, _params) do
        conn
        |> put_status(:forbidden)
        |> render(TothApp.SessionView, "forbidden.json", error: "not authenticated")
    end
end
