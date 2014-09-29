class CreateStoryThemes < ActiveRecord::Migration
  def change
    create_table :story_themes do |t|
      t.string :name
      t.integer :creator_id
      t.integer :start_age
      t.integer :end_age

      t.timestamps
    end

    add_index :story_themes, :creator_id
  end
end
