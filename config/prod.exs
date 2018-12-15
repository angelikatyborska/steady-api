use Mix.Config

config :steady_api, SteadyAPIWeb.Endpoint, http: [:inet6, port: System.get_env("PORT") || 4000]

defmodule CORSConfig do
  # Configuring this value via a function is the only way to have the configuration read during runtime.
  # Runtime configuration is important to produce deployable artifacts that can be easily deployed in multiple environments.
  #
  # This is in a module because, quoting `cors_plug` documentation:
  # > Caveat: Anonymous functions are not possible as they can't be quoted.
  def origin do
    (System.get_env("CORS_ORIGIN") || "") |> String.split(",")
  end
end

config :cors_plug,
  origin: &CORSConfig.origin/0

# Do not print debug messages in production
config :logger, level: :info
