defmodule UrlShortener.Repo do
  use Ecto.Repo,
    otp_app: :url_shortener,
    adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    # Unfortunately, Ecto makes this super difficult because it relies on mix
    # config still. One day we'll have nice things...
    runtime_config = Vapor.load!(UrlShortener.Config).repo
    config         = Keyword.merge(config, Enum.into(runtime_config, []))

    {:ok, config}
  end
end
