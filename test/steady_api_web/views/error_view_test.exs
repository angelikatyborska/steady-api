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
    actual = render(SteadyAPIWeb.ErrorView, "404.json", [])

    expected = %{
      error: %{
        reason: "Not Found",
        status: 404
      }
    }

    assert actual == expected
  end

  test "renders 500.html" do
    actual = render(SteadyAPIWeb.ErrorView, "500.json", [])

    expected = %{
      error: %{
        reason: "Internal Server Error",
        status: 500
      }
    }

    assert actual == expected
  end
end
