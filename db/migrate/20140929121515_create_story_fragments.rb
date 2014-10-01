class CreateStoryFragments < ActiveRecord::Migration
  def change
    create_table :story_fragments do |t|
      t.text :content
      t.integer :story_id
      t.references :creator, polymorphic: true

      t.timestamps
    end

    add_index :story_fragments, :story_id
    add_index :story_fragments, [ :creator_id, :creator_type ]
  end
end
