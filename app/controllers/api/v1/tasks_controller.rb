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
        tasks = task.list.tasks
        start_position = task.order 
        new_position = params[:order]

        sorted_tasks = (tasks.sort_by { |task | task.order })
        sliced_task = sorted_tasks.slice!(start_position, 1)

        recombined = (sorted_tasks.insert(new_position, sliced_task)).flatten
        reordered_tasks = recombined.each_with_index { | t, i | t.update(order: i) }

        render json: reordered_tasks
    end

    def update_task_list_id 
        task = Task.find(params[:id])
        tasks = task.list.tasks

        new_position = params[:order]
        finish_list = List.find(params[:task][:list_id])
        sorted_finish = finish_list.tasks.sort_by { |task | task.order }


        start_siblings_sorted = (tasks - [task]).sort_by {| task | task.order}

        reordered_start_tasks = start_siblings_sorted.each_with_index { | t, i | t.update(order: i) }

        task.list_id = finish_list.id
        recombined = (sorted_finish.insert(new_position, task )).flatten
        reordered_tasks = (recombined.each_with_index { | t, i | t.update(order: i) }).sort_by { |task | task.order }

        render json: [reordered_start_tasks, reordered_tasks]
        # byebug
    end

    def destroy 
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

# keep a state of the list or task id's in an array. 
# id: { 
    # 'homework': [0, 3, 2, 1],
    # 'chores': []
# }

