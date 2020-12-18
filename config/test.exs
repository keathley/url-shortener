use Mix.Config

config :url_shortener, :sql_sandbox, true

config :url_shortener, UrlShortenerWeb.Endpoint,
  http: [port: 4002],
  server: true

config :url_shortener, UrlShortener.Repo,
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warn

config :wallaby,
  driver: Wallaby.Chrome,
  chromedriver: [
    headless: true
  ],
  otp_app: :url_shortener,
  js_errors: true,
  js_logger: false,
  screenshot_on_failure: true
