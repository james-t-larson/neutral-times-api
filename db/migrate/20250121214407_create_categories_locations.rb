class CreateCategoriesLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :categories_locations do |t|
      t.references :category, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
    end

    add_index :categories_locations, [ :category_id, :location_id ], unique: true
  end
end
