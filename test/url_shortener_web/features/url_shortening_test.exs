defmodule UrlShortener.UrlShorteningTest do
  use ExUnit.Case, async: false
  use Wallaby.Feature, :url_shortener

  import Wallaby.Query

  @long_link "https://keathley.io"

  feature "users can create short urls and follow them", %{session: session} do
    session =
      session
      |> visit("/")
      |> fill_in(text_field("Link you want to shorten"), with: @long_link)
      |> click(button("Shorten"))
      |> assert_has(css("a.short-url"))

    code =
      session
      |> Wallaby.Browser.text(css("a.short-url"))
      |> URI.parse()
      |> Map.get(:path)

    session =
      session
      |> visit(code)

    eventually(fn ->
      assert current_url(session) == @long_link <> "/"
    end)
  end

  defp eventually(f, attempts \\ 10)
  defp eventually(f, attempts) do
    f.()
  rescue
    error ->
      if attempts <= 0 do
        reraise error, __STACKTRACE__
      else
        :timer.sleep(300)
        eventually(f, attempts - 1)
      end
  end
end
