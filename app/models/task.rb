class Task < ApplicationRecord
    belongs_to :list

    def reorder_after_destroy
        sibling_tasks = self.list.tasks.sort_by { | t | t.order }
        sibling_tasks.each_with_index { | t, i | t.update(order: i) }
    end

    def update_task_order(start_position, end_position, list_id) 
        tasks = self.list.tasks

        sorted_tasks = (tasks.sort_by { |task | task.order })
        sliced_task = sorted_tasks.slice!(start_position, 1)

        recombined = (sorted_tasks.insert(end_position, sliced_task)).flatten
        reordered_tasks = recombined.each_with_index { | t, i | t.update(order: i) }
        # if task.list_id !== finish_list = List.find(params[:task][:list_id]) then do x
    end

    def move_task_to_new_list(end_position, end_list_id)
        tasks = self.list.tasks



    end

    # def reorder_tasks(tasks, start_position, new_position)
        
    #     sorted_tasks = tasks.sort_by { |task | task.order }

    #     sliced_task = sorted_tasks.slice!(start_position, 1)
    #     recombined = (sorted_tasks.insert(new_position, sliced_task)).flatten
    #     reordered_tasks = recombined.each_with_index { | t, i | t.update(order: i) }
    #     return reordered_tasks
    # end

        
    # def splice_siblings(start_position, new_position, list_id)
    #     # a:0, b:1, c:2, d:3 
    #     # => a:0, d:1, b:2, c:3
    #     ## b:1+1 c:2+1 d:3-2
    #     sorted_tasks = (List.find(list_id).tasks).sort_by { |task | task.order }
    #     # sorted_tasks = (List.find(params([:list_id])).tasks).sort_by { |task | task.order }
        
    #     new_task_order = sorted_tasks.splice(start_position, 1)
    #     reordered_tasks = sorted_tasks.splice(new_position, 0, ...new_task_order)
    #     # the re-ordered tasks wihtout updated orders. 
    #     reordered_tasks.each_with_index { | t, i | t.update(order: i) }

    # end
end

