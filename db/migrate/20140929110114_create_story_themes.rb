class CreateStoryThemes < ActiveRecord::Migration
  def change
    create_table :story_themes do |t|
      t.string :name
      t.integer :start_age
      t.integer :end_age
      t.references :creator, polymorphic: true
      t.string :source, default: 'contributed'

      t.timestamps
    end

    add_index :story_themes, [ :creator_id, :creator_type ]
  end
end
