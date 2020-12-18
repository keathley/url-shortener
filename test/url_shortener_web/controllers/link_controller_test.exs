defmodule UrlShortenerWeb.LinkControllerTest do
  use UrlShortenerWeb.ConnCase

  alias UrlShortener.LinkManager
  alias Plug.Conn

  @external_link "https://keathley.io"

  describe "GET /:code" do
    test "redirects to the original url", %{conn: conn} do
      {:ok, link} = LinkManager.create_link(@external_link)
      conn = get(conn, "/#{link.code}")
      assert conn.status == 302
      assert Conn.get_resp_header(conn, "location") == [@external_link]
    end

    test "returns a 404 if no code is found", %{conn: conn} do
      conn = get(conn, "/123abc")
      assert conn.status == 404
    end
  end

  describe "POST /" do
    test "shows preview if the url is a real url", %{conn: conn} do
      conn = post(conn, "/", %{url: @external_link})
      assert conn.status == 302
    end

    test "returns an error if the url is not an actual url", %{conn: conn} do
      conn = post(conn, "/", %{url: "abc123"})
      assert conn.status == 400
    end
  end
end
