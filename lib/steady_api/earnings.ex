defmodule SteadyAPI.Earnings do
  @enforce_keys [:audience_count]
  defstruct audience_count: nil,
            conversion_percentage: 5,
            monthly_amount_in_cents_per_user: 500,
            predicted_monthly_earning_in_cents: nil

  @type t :: %SteadyAPI.Earnings{}

  @doc """
    Takes statistics about the audience and estimates the earnings.

    It truncates fractions of cents.
  """
  @spec estimate(integer(), map()) :: SteadyAPI.Earnings.t()
  def estimate(audience_count, params \\ %{}) do
    earnings = new(audience_count, params)

    predicted =
      earnings.audience_count
      |> Kernel.*(earnings.conversion_percentage)
      |> Kernel.*(0.01)
      |> Kernel.*(earnings.monthly_amount_in_cents_per_user)
      |> trunc()

    %SteadyAPI.Earnings{earnings | predicted_monthly_earning_in_cents: predicted}
  end

  defp new(audience_count, params) do
    params = Map.take(params, [:conversion_percentage, :monthly_amount_in_cents_per_user])

    %SteadyAPI.Earnings{audience_count: audience_count}
    |> Map.merge(params)
  end
end
