defmodule UrlShortener.LinkManager.Link do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "links" do
    field :code, :binary
    field :original_url, EctoURI

    timestamps()
  end

  def changeset(link \\ %__MODULE__{}, params) do
    link
    |> cast(params, [:code, :original_url])
    |> validate_required([:code, :original_url])
  end
end
