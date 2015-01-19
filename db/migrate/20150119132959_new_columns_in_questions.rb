class NewColumnsInQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :theme_id, :integer, default: 0

    add_index :questions, :theme_id
  end
end
