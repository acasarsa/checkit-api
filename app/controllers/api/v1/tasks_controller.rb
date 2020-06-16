class Api::V1::TasksController < ApplicationController

    def show 

        task = Task.find(params[:id])
        render json: task
    end

    def index 
        tasks = (List.find(params[:list_id]).tasks).sort_by { |task | task.order }
        render json: tasks
    end

    def create 
        task = Task.create!(task_params)
        render json: task
    end

    def update
        task = Task.find(params[:id])
        task.update(task_params)
        render json: task
    end

    def update_order 
# refactor this later to change the route so it just goes to list/:id/tasks u don't need to go to the single
# List.find(params[:list_id]).tasks
        task = Task.find(params[:id])
        tasks = task.list.tasks
        start_position = task.order 
        new_position = params[:order]
        

        sorted_tasks = (tasks.sort_by { |task | task.order })

        sliced_task = sorted_tasks.slice!(start_position, 1)
        # byebug
        # moved_task = sliced_task[0].update(list_id: destinationID)
        # if sliced_task[0].list_id != 
        # recombined = (sorted_tasks.insert(new_position, moved_task)).flatten
        recombined = (sorted_tasks.insert(new_position, sliced_task)).flatten
        reordered_tasks = recombined.each_with_index { | t, i | t.update(order: i) }

        render json: reordered_tasks
# if i move a 2nd time it breaks on the t.update order 
    end

    def update_task_list_id 
        task = Task.find(params[:id])
        # task id right now is 132 text: "1"
        tasks = task.list.tasks

        new_position = params[:order]
        finish_list = List.find(params[:task][:list_id])
        sorted_finish = finish_list.tasks.sort_by { |task | task.order }


        start_siblings_sorted = (tasks - [task]).sort_by {| task | task.order}
        reordered_start_tasks = start_siblings_sorted.each_with_index { | t, i | t.update(order: i) }
        
        # seems okay so far
        # task.update(list_id: finish_list.id)
        task.list_id = finish_list.id
        # task.update(list_id: finish_list.id)

        recombined = (sorted_finish.insert(new_position, task )).flatten
        # task.save
        # byebug
        reordered_tasks = (recombined.each_with_index { | t, i | t.update(order: i) }).sort_by { |task | task.order }
        # reordered_tasks.save
        render json: [reordered_start_tasks, reordered_tasks]
        # byebug
# see if u can just update the list itself to avoid looking through all the lists. 
    end

    def destroy 
# if u hit some strang errors it could be due to nexted routes where you need to do something with List like in the index action
        task = Task.find(params[:id])
        task.destroy
        remaining_tasks = task.reorder_after_destroy
        render json: remaining_tasks
    end

    private 

    def task_params
        params.require(:task).permit(:list_id, :order, :text, :isDone, :isPinned)
    end

end
