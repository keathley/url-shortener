defmodule UrlShortener.Config do
  @moduledoc """
  Defines common runtime configuration.
  """
  use Vapor.Planner

  dotenv()

  config :url_shortener, env([
    {:base_url, "BASE_URL", map: &URI.parse/1}
  ])

  config :repo, env([
    {:url, "DB_URL"},
    {:pool_size, "DB_POOL_SIZE", default: 10, map: &String.to_integer/1},
    {:ssl, "DB_USE_SSL", default: false, map: &String.to_existing_atom/1}
  ])

  def get(path) when is_list(path) do
    config = load!()
    get_in(config, path)
  end

  def load! do
    :persistent_term.get({__MODULE__, :config})
  catch
    _, _ ->
      config = Vapor.load!(__MODULE__)
      :persistent_term.put({__MODULE__, :config}, config)
      config
  end
end
