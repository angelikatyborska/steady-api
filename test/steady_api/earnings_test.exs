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
end
