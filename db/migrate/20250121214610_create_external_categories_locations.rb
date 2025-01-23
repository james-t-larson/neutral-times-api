class CreateExternalCategoriesLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :external_categories_locations do |t|
      t.references :external_category, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
    end

    add_index :external_categories_locations, [ :external_category_id, :location_id ], unique: true
  end
end
