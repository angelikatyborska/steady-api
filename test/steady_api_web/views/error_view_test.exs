defmodule SteadyAPIWeb.ErrorViewTest do
  use SteadyAPIWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 422.json" do
    actual = render(SteadyAPIWeb.ErrorView, "422.json", %{reason: "Reason..."})

    expected = %{
      error: %{
        reason: "Reason...",
        status: 422
      }
    }

    assert actual == expected
  end

  test "renders 404.html" do
    assert render_to_string(SteadyAPIWeb.ErrorView, "404.html", []) == "Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(SteadyAPIWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end
