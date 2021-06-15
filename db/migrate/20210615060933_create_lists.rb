class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      
      t.integer :user_id
      t.date :date
      t.text :first_item
      t.text :second_item
      t.text :third_item
      t.timestamps
    end
  end
end
