class Task < ApplicationRecord
    belongs_to :list

    def reorder_after_destroy
        sibling_tasks = self.list.tasks.sort_by { | t | t.order }
        sibling_tasks.each_with_index { | t, i | t.update(order: i) }
    end

    def reorder_siblings(start_position, new_position)

        sibling_tasks = (self.list.tasks - [self].sort_by { |t | t.order })

        if start_position < new_position
            less_than = sibling_tasks = sibling_tasks.select { | t | t.order <= new_position }
            less_than.each_with_index { | t, i | t.update(order: i) }

        elsif start_position > new_position
            greater_than = sibling_tasks.select { | t | t.order >= new_position }
            greater_than.each.with_index(new_position) { | t, i | t.update(order: i + 1) }

        end
    end
end
