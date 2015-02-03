class AddTrainedColumnInQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :trained, :boolean, default: false
  end
end
