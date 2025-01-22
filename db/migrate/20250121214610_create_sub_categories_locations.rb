class CreateSubCategoriesLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :sub_categories_locations do |t|
      t.references :sub_category, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
    end

    add_index :sub_categories_locations, [ :sub_category_id, :location_id ], unique: true
  end
end
