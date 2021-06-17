class AddDoneToLists < ActiveRecord::Migration[5.2]
  def change
    add_column :lists, :done, :boolean, default: false, null: false
  end
end
