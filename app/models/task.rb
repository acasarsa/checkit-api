class Task < ApplicationRecord
    belongs_to :list

    def reorder_after_destroy
        sibling_tasks = self.list.tasks.sort_by { | t | t.order }
        sibling_tasks.each_with_index { | t, i | t.update(order: i) }
    end
end
