defmodule TothApp.AppControllerTest do
    use TothApp.ConnCase

    test "GET /", %{conn: conn} do
        conn = get conn, "/"
        assert html_response(conn, 200) =~ "Toth App"
    end
end
