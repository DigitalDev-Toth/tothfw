defmodule TothApp.ErrorViewTest do
    use TothApp.ConnCase, async: true

    import Phoenix.View

    test "renders 404.html" do
        assert render_to_string(TothApp.ErrorView, "404.html", []) ==
           "Page not found"
    end

    test "render 500.html" do
        assert render_to_string(TothApp.ErrorView, "500.html", []) ==
           "Server internal error"
    end

    test "render any other" do
        assert render_to_string(TothApp.ErrorView, "505.html", []) ==
           "Server internal error"
    end
end
