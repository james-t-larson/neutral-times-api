class AddSourcesToArticles < ActiveRecord::Migration[7.2]
  def change
    add_column :articles, :sources, :string
  end
end
