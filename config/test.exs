use Mix.Config

config :url_shortener, UrlShortenerWeb.Endpoint,
  http: [port: 4002],
  server: true

config :logger, level: :warn
