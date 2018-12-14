defmodule SteadyAPIWeb.EarningsView do
  use SteadyAPIWeb, :view

  def render("index.json", %{earnings: %SteadyAPI.Earnings{} = earnings}) do
    %{
      audience_count: earnings.audience_count,
      conversion_percentage: earnings.conversion_percentage,
      monthly_amount_in_cents_per_user: earnings.monthly_amount_in_cents_per_user,
      predicted_monthly_earning_in_cents: earnings.predicted_monthly_earning_in_cents
    }
  end
end
