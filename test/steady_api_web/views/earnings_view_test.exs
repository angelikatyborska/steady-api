defmodule SteadyAPIWeb.EarningsViewTest do
  use SteadyAPIWeb.ConnCase, async: true

  import Phoenix.View

  test "render index.json" do
    earnings = %SteadyAPI.Earnings{
      audience_count: 1,
      conversion_percentage: 2,
      monthly_amount_in_cents_per_user: 3,
      predicted_monthly_earning_in_cents: 4
    }

    actual = render(SteadyAPIWeb.EarningsView, "index.json", %{earnings: earnings})

    expected = %{
      audience_count: 1,
      conversion_percentage: 2,
      monthly_amount_in_cents_per_user: 3,
      predicted_monthly_earning_in_cents: 4
    }

    assert actual == expected
  end
end
