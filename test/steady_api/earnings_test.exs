defmodule SteadyAPI.EarningsTest do
  use ExUnit.Case

  alias SteadyAPI.Earnings

  describe "new" do
    test "has one required argument" do
      actual = Earnings.new(123)
      expected = %Earnings{audience_count: 123}

      assert actual == expected
    end

    test "accepts additional params" do
      actual = Earnings.new(123, %{conversion_percentage: 234})
      expected = %Earnings{audience_count: 123, conversion_percentage: 234}

      assert actual == expected
    end

    test "rejects random params" do
      result = Earnings.new(123, %{conversion_percentage: 234, fruit: "banana"})

      assert result.conversion_percentage == 234
      assert Map.get(result, :fruit) == nil
    end
  end

  describe "estimate" do
    test "uses defaults" do
      actual = Earnings.new(10_000) |> Earnings.estimate()
      expected = %Earnings{audience_count: 10_000, predicted_monthly_earning_in_cents: 250_000}

      assert actual == expected
    end

    test "returns fractions" do
      actual =
        Earnings.new(152_541, %{monthly_amount_in_cents_per_user: 515, conversion_percentage: 7})
        |> Earnings.estimate()

      expected = %Earnings{
        audience_count: 152_541,
        monthly_amount_in_cents_per_user: 515,
        conversion_percentage: 7,
        predicted_monthly_earning_in_cents: 5_499_103.050000001
      }

      assert actual == expected
    end

    test "depends linearly on the audience count" do
      x1 =
        10_000
        |> Earnings.new()
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      x10 =
        100_000
        |> Earnings.new()
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      x100 =
        1_000_000
        |> Earnings.new()
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      assert x1 * 10 == x10
      assert x1 * 100 == x100
    end

    test "depends linearly on the conversion" do
      x1 =
        10_000
        |> Earnings.new(%{conversion_percentage: 1})
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      x10 =
        10_000
        |> Earnings.new(%{conversion_percentage: 10})
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      x100 =
        10_000
        |> Earnings.new(%{conversion_percentage: 100})
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      assert x1 * 10 == x10
      assert x1 * 100 == x100
    end

    test "depends linearly on the monthly amount per user" do
      x1 =
        10_000
        |> Earnings.new(%{monthly_amount_in_cents_per_user: 1})
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      x10 =
        10_000
        |> Earnings.new(%{monthly_amount_in_cents_per_user: 10})
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      x100 =
        10_000
        |> Earnings.new(%{monthly_amount_in_cents_per_user: 100})
        |> Earnings.estimate()
        |> Map.get(:predicted_monthly_earning_in_cents)

      assert x1 * 10 == x10
      assert x1 * 100 == x100
    end
  end
end
