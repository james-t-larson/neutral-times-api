class CreateSubCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :sub_categories do |t|
      t.string :name, null: false
      t.references :category, null: false, foreign_key: true
    end
  end
end
