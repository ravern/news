defmodule SGFeed.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :base_url,     :string
      add :permalink,    :string
      add :category,     :string
      add :title,        :string
      add :subtitle,     :string
      add :highlight,    :text
      add :body,         :text
      add :thumbnail,    :text
      add :image,        :text
      add :author,       :string
      add :published_at, :naive_datetime
    end

    create unique_index(:articles, [:permalink])
  end
end
