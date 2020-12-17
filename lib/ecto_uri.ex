defmodule EctoURI do
  @moduledoc """
  An ecto type for storing URIs.
  """
  use Ecto.Type

  def type, do: :map

  def cast(uri) when is_binary(uri) do
    {:ok, URI.parse(uri)}
  end
  def cast(%URI{}=uri), do: {:ok, uri}
  def cast(_), do: :error

  # If we're loading from the database and its a map, we just put the data
  # into a URI struct.
  def load(data) when is_map(data) do
    data = for {k, v} <- data, do: {String.to_existing_atom(k), v}
    {:ok, struct!(URI, data)}
  end

  # If we're storing data in the database we require that everything has already
  # been cast to a URI struct. So we just need to strip off the struct keys and
  # we can store the values as a map.
  def dump(uri) do
    if match?(%URI{}, uri) do
      {:ok, Map.from_struct(uri)}
    else
      :error
    end
  end
end
