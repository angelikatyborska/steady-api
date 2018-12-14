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

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
