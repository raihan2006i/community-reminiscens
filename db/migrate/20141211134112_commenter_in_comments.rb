class CommenterInComments < ActiveRecord::Migration
  def up
    change_table :comments do |t|
      t.remove :person_id
      t.references :commenter, polymorphic: true
    end
    add_index :comments, [:commenter_id, :commenter_type]
  end

  def down
    remove_index :comments, [:commenter_id, :commenter_type]
    change_table :comments do |t|
      t.column :person_id, :integer
      t.remove_references :commenter, polymorphic: true
    end
  end
end
