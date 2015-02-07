class AddTitleInStories < ActiveRecord::Migration
  def change
    add_column :stories, :title, :string, index: true
  end
end
