defmodule SteadyAPI.EarningsTest do
  use ExUnit.Case

  alias SteadyAPI.Earnings

  describe "estimate" do
    test "uses defaults" do
      actual = Earnings.estimate(10_000)
      expected = %Earnings{audience_count: 10_000, predicted_monthly_earning_in_cents: 250_000}

      assert actual == expected
    end

    test "rejects random params" do
      result = Earnings.estimate(123, %{conversion_percentage: 234, fruit: "banana"})

      assert result.conversion_percentage == 234
      assert Map.get(result, :fruit) == nil
    end

    test "truncates fractions" do
      actual =
        Earnings.estimate(10, %{monthly_amount_in_cents_per_user: 9, conversion_percentage: 1})

      expected = %Earnings{
        audience_count: 10,
        monthly_amount_in_cents_per_user: 9,
        conversion_percentage: 1,
        predicted_monthly_earning_in_cents: 0
      }

      assert actual == expected
    end

    test "depends linearly on the audience count" do
      x1 =
        10_000
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      x10 =
        100_000
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      x100 =
        1_000_000
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      assert x1 * 10 == x10
      assert x1 * 100 == x100
    end

    test "depends linearly on the conversion" do
      x1 =
        10_000
        |> Earnings.estimate(%{conversion_percentage: 1})
        |> Map.get(:predicted_monthly_earning_in_cents)

      x10 =
        10_000
        |> Earnings.estimate(%{conversion_percentage: 10})
        |> Map.get(:predicted_monthly_earning_in_cents)

      x100 =
        10_000
        |> Earnings.estimate(%{conversion_percentage: 100})
        |> Map.get(:predicted_monthly_earning_in_cents)

      assert x1 * 10 == x10
      assert x1 * 100 == x100
    end

    test "depends linearly on the monthly amount per user" do
      x1 =
        10_000
        |> Earnings.estimate(%{monthly_amount_in_cents_per_user: 1})
        |> Map.get(:predicted_monthly_earning_in_cents)

      x10 =
        10_000
        |> Earnings.estimate(%{monthly_amount_in_cents_per_user: 10})
        |> Map.get(:predicted_monthly_earning_in_cents)

      x100 =
        10_000
        |> Earnings.estimate(%{monthly_amount_in_cents_per_user: 100})
        |> Map.get(:predicted_monthly_earning_in_cents)

      assert x1 * 10 == x10
      assert x1 * 100 == x100
    end
  end
end
