class CreateExternalArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :external_articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.integer :event_id, null: false
      t.float :relevance_score, default: 0.0
      t.string :source
      t.string :url, null: false
      t.string :location
      t.references :category, null: false, foreign_key: true
    end
  end
end
