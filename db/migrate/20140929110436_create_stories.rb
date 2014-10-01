class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :teller_id
      t.integer :story_theme_id
      t.integer :story_context_id
      t.date :telling_date
      t.references :creator, polymorphic: true

      t.timestamps
    end

    add_index :stories, :teller_id
    add_index :stories, [ :creator_id, :creator_type ]
    add_index :stories, :story_theme_id
    add_index :stories, :story_context_id
  end
end
