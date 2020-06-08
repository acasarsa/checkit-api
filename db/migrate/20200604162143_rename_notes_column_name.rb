class RenameNotesColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :notes, :content, :text
  end
end
