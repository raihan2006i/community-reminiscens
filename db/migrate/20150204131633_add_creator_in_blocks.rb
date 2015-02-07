class AddCreatorInBlocks < ActiveRecord::Migration
  def up
    change_table :blocks do |t|
      t.references :creator, polymorphic: true
    end
    add_index :blocks, [:creator_id, :creator_type]
  end

  def down
    remove_index :blocks, [:creator_id, :creator_type]
    change_table :blocks do |t|
      t.remove_references :creator, polymorphic: true
    end
  end
end
