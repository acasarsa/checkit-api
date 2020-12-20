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
        task = Task.find(params[:id])
        start_position = task.order 
        end_position = params[:order]
        list_id = task.list_id
        
        reordered_tasks = task.update_task_order(start_position, end_position, list_id)

        render json: reordered_tasks
    end

    def move_task_to_new_list 
        task = Task.find(params[:id])
        tasks = task.list.tasks # remove
        start_list_id = params[:list_id] # is the start_list id not needed i think
        end_list_id = params[:task][:list_id] # is end_list id
        end_position = params[:order]

        end_list = List.find(params[:task][:list_id]) # move into model
        # byebug
        task.destroy

        
        sorted_finish = end_list.tasks.sort_by { |task | task.order } #remove


        start_siblings_sorted = (tasks - [task]).sort_by {| task | task.order}

        reordered_start_tasks = start_siblings_sorted.each_with_index { | t, i | t.update(order: i) }

        task.list_id = end_list_id # remove
        recombined = (sorted_finish.insert(new_position, task )).flatten
        reordered_tasks = (recombined.each_with_index { | t, i | t.update(order: i) }).sort_by { |task | task.order }

        render json: [reordered_start_tasks, reordered_tasks]
        # byebug
    end

    def destroy 
        task = Task.find(params[:id])
        task.destroy
        remaining_tasks = task.reorder_after_destroy
        byebug
        render json: remaining_tasks
    end

    private 

    def task_params
        params.require(:task).permit(:list_id, :order, :text, :isDone, :isPinned)
    end

end

# keep a state of the list or task id's in an array. 
# id: { 
    # 'homework': [0, 3, 2, 1],
    # 'chores': []
# }

