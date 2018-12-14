defmodule SteadyAPIWeb.EarningsController do
  use SteadyAPIWeb, :controller

  def index(conn, params) do
    with {:params, %{audience_count: audience_count} = params} <- {:params, parse_params(params)},
         {:estimate, {:ok, earnings}} <-
           {:estimate, SteadyAPI.Earnings.estimate(audience_count, params)} do
      render(conn, "index.json", %{earnings: earnings})
    else
      {:estimate, {:error, error}} -> unprocessable_entity(conn, error)
      {:params, _} -> unprocessable_entity(conn, "missing required parameter 'audience_count'")
    end
  end

  defp parse_params(params) do
    allowed_integer_params = [
      :audience_count,
      :conversion_percentage,
      :monthly_amount_in_cents_per_user
    ]

    allowed_integer_params
    |> Enum.reduce(%{}, fn key, acc ->
      case Map.get(params, Atom.to_string(key)) do
        nil -> acc
        value -> Map.put_new(acc, key, parse_int_if_possible(value))
      end
    end)
  end

  defp parse_int_if_possible(value) do
    case Integer.parse(value) do
      {integer, ""} -> integer
      _ -> value
    end
  end

  defp unprocessable_entity(conn, reason) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(SteadyAPIWeb.ErrorView)
    |> render("422.json", %{reason: reason})
  end
end
