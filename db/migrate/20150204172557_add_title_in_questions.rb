class AddTitleInQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :title, :string, index: true
  end
end
