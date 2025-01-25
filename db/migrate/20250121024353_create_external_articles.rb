class CreateExternalArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :external_articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :event_id
      t.float :relevance, default: 0.0
      t.float :sentiment, default: 0.0
      t.string :source
      t.string :url, null: false
      t.string :location
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
