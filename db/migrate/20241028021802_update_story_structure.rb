class UpdateStoryStructure < ActiveRecord::Migration[7.1]
  def change
    rename_table :stories, :articles

    drop_table :contents do |t|
      t.string :sub_title
      t.text :text
      t.integer :story_id
      t.timestamps
    end

    add_column :articles, :content, :text
  end
end
