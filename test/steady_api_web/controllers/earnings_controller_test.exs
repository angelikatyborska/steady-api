defmodule SteadyAPIWeb.EarningsControllerTest do
  use SteadyAPIWeb.ConnCase

  describe "GET /" do
    test "success - only minimal params", %{conn: conn} do
      params = %{"audience_count" => "40000"}

      actual =
        conn
        |> get(Routes.earnings_path(conn, :index, params))
        |> json_response(200)

      expected = %{
        "audience_count" => 40000,
        "conversion_percentage" => 5,
        "monthly_amount_in_cents_per_user" => 500,
        "predicted_monthly_earning_in_cents" => 1_000_000
      }

      assert actual == expected
    end

    test "success - all possible params", %{conn: conn} do
      params = %{
        "audience_count" => "40000",
        "conversion_percentage" => "10",
        "monthly_amount_in_cents_per_user" => "300"
      }

      actual =
        conn
        |> get(Routes.earnings_path(conn, :index, params))
        |> json_response(200)

      expected = %{
        "audience_count" => 40000,
        "conversion_percentage" => 10,
        "monthly_amount_in_cents_per_user" => 300,
        "predicted_monthly_earning_in_cents" => 1_200_000
      }

      assert actual == expected
    end

    test "missing required params", %{conn: conn} do
      params = %{}

      actual =
        conn
        |> get(Routes.earnings_path(conn, :index, params))
        |> json_response(422)

      expected = %{
        "error" => %{
          "reason" => "missing required parameter 'audience_count'",
          "status" => 422
        }
      }

      assert actual == expected
    end

    test "invalid required params", %{conn: conn} do
      params = %{
        "audience_count" => "banana"
      }

      actual =
        conn
        |> get(Routes.earnings_path(conn, :index, params))
        |> json_response(422)

      expected = %{
        "error" => %{
          "reason" => "value of 'audience_count' must be a non-negative integer (got \"banana\")",
          "status" => 422
        }
      }

      assert actual == expected
    end

    test "invalid optional params", %{conn: conn} do
      params = %{
        "audience_count" => "10000",
        "conversion_percentage" => "apple",
        "monthly_amount_in_cents_per_user" => "3.1"
      }

      actual =
        conn
        |> get(Routes.earnings_path(conn, :index, params))
        |> json_response(422)

      expected = %{
        "error" => %{
          "reason" =>
            "value of 'conversion_percentage' must be a non-negative integer (got \"apple\"), " <>
              "value of 'monthly_amount_in_cents_per_user' must be a non-negative integer (got \"3.1\")",
          "status" => 422
        }
      }

      assert actual == expected
    end
  end
end
