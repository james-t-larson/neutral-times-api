class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :name
      t.references :sub_category, null: false, foreign_key: true
    end
  end
end
