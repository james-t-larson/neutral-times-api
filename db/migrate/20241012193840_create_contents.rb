class CreateContents < ActiveRecord::Migration[7.2]
  def change
    create_table :contents do |t|
      t.string :sub_title
      t.text :text
      t.references :story, null: false, foreign_key: true

      t.timestamps
    end
  end
end
