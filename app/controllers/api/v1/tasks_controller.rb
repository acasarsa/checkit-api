class Api::V1::TasksController < ApplicationController

    def show 

        task = Task.find(params[:id])
        render json: task
    end

    def index 
        tasks = List.find(params[:list_id]).tasks.sort_by{|task| task.order}
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
        new_position = params[:order]
        task.reorder_siblings(start_position, new_position)

        task.update(task_params)
        reordered_tasks = List.find(params[:list_id]).tasks.sort_by{|task| task.order}
        render json: reordered_tasks

    end

    def destroy 
# if u hit some strang errors it could be due to nexted routes where you need to do something with List like in the index action
        task = Task.find(params[:id])
        task.destroy
        remaining_tasks = task.reorder_after_destroy.sort_by{|task| task.order}
        render json: remaining_tasks
    end

    private 

    def task_params
        params.require(:task).permit(:list_id, :order, :text, :isDone, :isPinned)
    end

end
