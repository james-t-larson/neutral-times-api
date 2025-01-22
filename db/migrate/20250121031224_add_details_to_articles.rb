class AddDetailsToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :original_article_id, :integer
    add_column :articles, :category_id, :integer
    add_column :articles, :image, :string
    add_column :articles, :sentiment_score, :float, default: 0.0
    add_column :articles, :event_id, :integer
    add_column :articles, :location, :string

    add_index :articles, :category_id
    add_index :articles, :original_article_id

    add_foreign_key :articles, :categories, column: :category_id
    add_foreign_key :articles, :original_articles, column: :original_article_id
  end
end
