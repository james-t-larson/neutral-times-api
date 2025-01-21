class AddDetailsToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :original_article_id, :integer
    add_column :articles, :image, :string
    add_column :articles, :sentiment_score, :float, default: 0.0
    add_column :articles, :event_id, :integer
    add_column :articles, :location, :string

    add_index :articles, :original_article_id
  end
end
