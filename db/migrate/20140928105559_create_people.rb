class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :title
      t.date :birthday
      t.string :address
      t.string :city
      t.string :country
      t.string :phone
      t.string :mobile
      t.integer :user_id

      t.timestamps
    end

    add_index :people, :user_id
  end
end
