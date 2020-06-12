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
            byebug
        elsif start_position > new_position
            greater_than = sibling_tasks.select { | t | t.order >= new_position }
            byebug
            greater_than.each.with_index(new_position) { | t, i | t.update(order: i + 1) }
            byebug
        end
    end


    def splice_siblings(start_position, new_position, list_id)
        # a:0, b:1, c:2, d:3 
        # => a:0, d:1, b:2, c:3
        ## b:1+1 c:2+1 d:3-2
        sorted_tasks = (List.find(list_id).tasks).sort_by { |task | task.order }
        # sorted_tasks = (List.find(params([:list_id])).tasks).sort_by { |task | task.order }
        
        new_task_order = sorted_tasks.splice(start_position, 1)
        reordered_tasks = sorted_tasks.splice(new_position, 0, ...new_task_order)
        # the re-ordered tasks wihtout updated orders. 
        reordered_tasks.each_with_index { | t, i | t.update(order: i) }

    end
end

