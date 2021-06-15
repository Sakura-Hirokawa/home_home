class CreateListComments < ActiveRecord::Migration[5.2]
  def change
    create_table :list_comments do |t|
      
      t.integer :user_id
      t.integer :list_id
      t.text :comment
      t.timestamps
    end
  end
end
