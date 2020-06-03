class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.integer :list_id
      t.text :content
      t.boolean :isDone, default: 'false'
      t.boolean :isPinned, defaukt: 'false'

      t.timestamps
    end
  end
end
