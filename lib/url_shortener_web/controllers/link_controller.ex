defmodule UrlShortenerWeb.LinkController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.LinkManager
  alias Plug.Conn

  def new(conn, _params) do
    render(conn, :new, %{url: nil, short_url: nil})
  end

  def create(conn, %{"url" => url}) do
    case LinkManager.create_link(url) do
      {:ok, short_url} ->
        render(conn, :new, %{url: url, short_url: short_url})

      {:error, error} ->
        raise error
    end
  end

  def show(conn, %{"code" => code}) do
    case LinkManager.find_original_by_code(code) do
      {:ok, original_url} ->
        conn
        |> Conn.put_resp_header("location", original_url)
        |> Conn.send_resp(302, original_url)

      {:error, _} ->
        Conn.send_resp(conn, 404, "Not Found")
    end
  end
end
