class AddOrderColumnTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :order, :integer
  end
end
