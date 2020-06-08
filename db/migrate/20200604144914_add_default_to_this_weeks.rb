class AddDefaultToThisWeeks < ActiveRecord::Migration[6.0]
  def change
    change_column :this_weeks, :content, :text, default: ''
  end
end
