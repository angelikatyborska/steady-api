defmodule SteadyAPIWeb.ErrorView do
  use SteadyAPIWeb, :view

  def render("422.json", %{reason: reason}) do
    %{
      error: %{
        reason: reason,
        status: 422
      }
    }
  end

  def template_not_found(template, _assigns) do
    code =
      template
      |> String.split(".")
      |> hd()
      |> String.to_integer()

    %{
      error: %{
        reason: Plug.Conn.Status.reason_phrase(code),
        status: code
      }
    }
  end
end
