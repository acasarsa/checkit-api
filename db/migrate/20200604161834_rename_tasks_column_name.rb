class RenameTasksColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :tasks, :content, :text
  end
end
