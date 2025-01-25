class AddDetailsToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :external_article_id, :integer
    add_column :articles, :category_id, :integer
    add_column :articles, :image, :string
    add_column :articles, :sentiment_score, :float, default: 0.0
    add_column :articles, :event_id, :string
    add_column :articles, :location, :string

    add_foreign_key :articles, :categories, column: :category_id
    add_foreign_key :articles, :external_articles, column: :external_article_id
  end
end
