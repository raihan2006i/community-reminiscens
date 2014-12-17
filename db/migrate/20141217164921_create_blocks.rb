class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.integer :slot_id
      t.references :blockable, polymorphic: true

      t.timestamps
    end
    add_index :blocks, [:blockable_id, :blockable_type]
  end
end
