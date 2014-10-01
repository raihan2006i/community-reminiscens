class CreateStoryContexts < ActiveRecord::Migration
  def change
    create_table :story_contexts do |t|
      t.string :name
      t.references :creator, polymorphic: true
      t.string :source, default: 'contributed'

      t.timestamps
    end

    add_index :story_contexts, [ :creator_id, :creator_type ]
  end
end
