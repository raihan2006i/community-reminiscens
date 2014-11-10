class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps
    end
    add_attachment :attachments, :media
    add_index :attachments, [:attachable_id, :attachable_type]

  end

  def down
    remove_index :attachments, [:attachable_id, :attachable_type]
    remove_attachment :attachments, :media
    drop_table :attachments
  end
end
