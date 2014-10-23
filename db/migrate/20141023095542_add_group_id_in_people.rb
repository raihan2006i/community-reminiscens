class AddGroupIdInPeople < ActiveRecord::Migration
  def change
    add_column :people, :group_id, :integer, default: 0
    add_index :people, :group_id
  end
end
