class CreatorInAttachments < ActiveRecord::Migration
  def up
    change_table :attachments do |t|
      t.references :creator, polymorphic: true
    end
    add_index :attachments, [:creator_id, :creator_type]
  end

  def down
    remove_index :attachments, [:creator_id, :creator_type]
    change_table :attachments do |t|
      t.remove_references :creator, polymorphic: true
    end
  end
end
