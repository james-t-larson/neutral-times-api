class CreateCategoryLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :category_locations do |t|
      t.references :category, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
