class RemovePublishedAtFromArticles < ActiveRecord::Migration[7.2]
  def change
    remove_column :articles, :published_at, :datetime
  end
end
