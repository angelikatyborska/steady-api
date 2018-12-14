defmodule SteadyAPI.Earnings do
  @enforce_keys [:audience_count]
  defstruct audience_count: nil,
            conversion_percentage: 5,
            monthly_amount_in_cents_per_user: 500,
            predicted_monthly_earning_in_cents: nil

  @type t :: %SteadyAPI.Earnings{}

  @doc """
    Takes statistics about the audience and estimates the earnings.
    All statistics need to be integers, even the conversion percentage.

    It truncates fractions of cents.
  """
  @spec estimate(integer(), map()) :: SteadyAPI.Earnings.t()
  def estimate(audience_count, params \\ %{}) do
    case new(audience_count, params) do
      {:ok, earnings} -> {:ok, do_estimate(earnings)}
      {:error, error} -> {:error, error}
    end
  end

  defp do_estimate(earnings) do
    predicted =
      earnings.audience_count
      |> Kernel.*(earnings.conversion_percentage)
      |> Kernel.*(0.01)
      |> Kernel.*(earnings.monthly_amount_in_cents_per_user)
      |> trunc()

    %SteadyAPI.Earnings{earnings | predicted_monthly_earning_in_cents: predicted}
  end

  defp new(audience_count, params) do
    base = %SteadyAPI.Earnings{audience_count: audience_count}
    params = Map.take(params, Map.keys(base) -- [:__struct__])

    base
    |> Map.merge(params)
    |> validate()
  end

  defp validate(earnings) do
    integer_values = [:monthly_amount_in_cents_per_user, :conversion_percentage, :audience_count]

    errors =
      integer_values
      |> Enum.reduce([], fn key, errors ->
        value = Map.get(earnings, key)

        if is_integer(value) and value >= 0 do
          errors
        else
          ["value of '#{key}' must be a non-negative integer (got #{inspect(value)})" | errors]
        end
      end)

    if errors == [] do
      {:ok, earnings}
    else
      {:error, Enum.join(errors, ", ")}
    end
  end
end
