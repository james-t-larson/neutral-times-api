class CreatePrompts < ActiveRecord::Migration[7.2]
  def change
    create_table :prompts do |t|
      t.text :text, null: false
      t.float :sentiment, default: 0.0, null: false
      t.float :usage_count, default: 0.0, null: false

      t.timestamps
    end

    add_index :prompts, :text
  end
end
