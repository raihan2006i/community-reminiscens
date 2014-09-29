class CreateStoryContexts < ActiveRecord::Migration
  def change
    create_table :story_contexts do |t|
      t.string :name
      t.integer :creator_id

      t.timestamps
    end

    add_index :story_contexts, :creator_id
  end
end
