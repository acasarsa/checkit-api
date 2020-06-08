class AddDefaultToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :isPinned, :boolean, default: false
  end
end
