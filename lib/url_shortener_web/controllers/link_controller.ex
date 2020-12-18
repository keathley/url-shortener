defmodule UrlShortenerWeb.LinkController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.LinkManager
  alias Plug.Conn

  def new(conn, _params) do
    render(conn, :new, %{url: nil, short_url: nil})
  end

  def preview(conn, %{"code" => code}) do
    case LinkManager.find_original_by_code(code) do
      {:ok, original_url} ->
        short_url = LinkManager.build_short_url(code)
        render(conn, :new, %{url: original_url, short_url: short_url})

      {:error, _} ->
        Conn.send_resp(conn, 404, "Not Found")
    end
  end

  def create(conn, %{"url" => url}) do
    case LinkManager.create_link(url) do
      {:ok, link} ->
        redirect(conn, to: Routes.link_path(conn, :preview, link.code))

      {:error, :invalid} ->
        conn
        |> Conn.put_status(400)
        |> put_flash(:error, "Invalid URL")
        |> render(:new, %{url: url, short_url: nil})

      {:error, _} ->
        Conn.send_resp(conn, 503, "Error")
    end
  end

  def show(conn, %{"code" => code}) do
    case LinkManager.find_original_by_code(code) do
      {:ok, original_url} ->
        redirect(conn, external: original_url)

      {:error, _} ->
        Conn.send_resp(conn, 404, "Not Found")
    end
  end
end
