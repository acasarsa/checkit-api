class AddDefaultToNotes < ActiveRecord::Migration[6.0]
  def change
    change_column :notes, :content, :text, default: ''
  end
end
