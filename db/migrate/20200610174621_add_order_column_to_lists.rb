class AddOrderColumnToLists < ActiveRecord::Migration[6.0]
  def change
    add_column :lists, :order, :integer
  end
end
