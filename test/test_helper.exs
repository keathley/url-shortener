{:ok, _} = Application.ensure_all_started(:wallaby)
Application.put_env(:wallaby, :base_url, UrlShortenerWeb.Endpoint.url)

ExUnit.start()
