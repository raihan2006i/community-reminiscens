class ChangeDafaultValueOfStatusInSessions < ActiveRecord::Migration
  def up
    change_column :sessions, :status, :string, default: Session::STATUS_NOT_STARTED
  end

  def down
    change_column :sessions, :status, :string, default: nil
  end
end
