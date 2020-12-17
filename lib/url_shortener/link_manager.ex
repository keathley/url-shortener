defmodule UrlShortener.LinkManager do
  @moduledoc """
  This module provides an interface finding and creating short urls. All UI related
  concerns should pass through this module since it manages distribution of urls
  across the cluster.

  A "Link" is a domain specific term that refers to the "link" between an original
  url and the shortened version of the url.
  """

  alias __MODULE__.Link
  alias UrlShortener.Repo

  import Ecto.Query

  def create_link(url) when is_binary(url) do
    code      = generate_short_code(url)
    changeset = Link.changeset(%{original_url: url, code: code})

    with {:ok, link} <- upsert_link(changeset) do
      base_url  = UrlShortener.Config.get([:url_shortener, :base_url])
      short_url = URI.merge(base_url, link.code)
      {:ok, URI.to_string(short_url)}
    end
  end

  def find_original_by_code(code) when is_binary(code) do
    case Repo.one(original_url_query(code)) do
      nil ->
        {:error, :not_found}

      link ->
        {:ok, URI.to_string(link.original_url)}
    end
  end

  defp upsert_link(changeset) do
    Repo.insert(
      changeset,
      conflict_target: [:code, :original_url],
      on_conflict: :nothing,
      returning: [:original_url]
    )
  end

  defp original_url_query(code) do
    from l in Link,
      where: l.code == ^code,
      select: [:original_url]
  end

  # The idea here is to generate short codes for a given URL. We're going to use
  # a deterministic hashing scheme instead of a truly random one. This means that
  # links can be cached effectively without coordination.
  #
  # We generate the code by hashing the url with sha256 + encoding as hex. This gives
  # us the standard sha hash. We can then convert the hex representation to an integer.
  # Unless we have a collision in sha256 (highly unlikely), these integers will be
  # unique to ever website we'd realistically see. In order to get the short URL
  # we can pack this integer as a binary and encode the resulting binary as base64.
  # This means that our short code generation will be deterministic without coordination
  # and will avoid almost all collisions.
  defp generate_short_code(url) do
    url
    |> hash
    |> Base.encode16(case: :lower)
    |> String.to_integer(16)
    |> pack_bitstring
    |> Base.url_encode64
    |> String.replace(~r/==\n?/, "")
  end

  defp hash(str), do: :crypto.hash(:sha256, str)

  defp pack_bitstring(int), do: << int :: big-unsigned-32 >>
end
