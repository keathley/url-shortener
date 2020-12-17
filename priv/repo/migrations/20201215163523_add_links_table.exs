defmodule UrlShortener.Repo.Migrations.AddLinksTable do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :code, :string, null: false
      add :original_url, :map, null: false

      timestamps()
    end

    create index(:links, [:code])
    create index(:links, [:code, :original_url], unique: true)
  end
end
