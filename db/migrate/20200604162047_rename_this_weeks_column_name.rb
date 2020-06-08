class RenameThisWeeksColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :this_weeks, :content, :text
  end
end
