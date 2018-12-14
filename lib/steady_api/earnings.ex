defmodule SteadyAPI.Earnings do
  @enforce_keys [:audience_count]
  defstruct audience_count: nil,
            conversion_percentage: 5,
            monthly_amount_in_cents_per_user: 500,
            predicted_monthly_earning_in_cents: nil

  @type t :: %SteadyAPI.Earnings{}

  @spec new(integer(), map()) :: SteadyAPI.Earnings.t()
  def new(audience_count, params \\ %{}) do
    params = Map.take(params, [:conversion_percentage, :monthly_amount_in_cents_per_user])

    %SteadyAPI.Earnings{audience_count: audience_count}
    |> Map.merge(params)
  end
end