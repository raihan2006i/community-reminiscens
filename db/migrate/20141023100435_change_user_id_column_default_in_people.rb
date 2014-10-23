class ChangeUserIdColumnDefaultInPeople < ActiveRecord::Migration
  def up
    change_column_default :people, :user_id, 0
  end

  def down
    change_column_default :people, :user_id, nil
  end
end
