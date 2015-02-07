class AddTitleInSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :title, :string, index: true
  end
end
