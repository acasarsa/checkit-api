class Api::V1::TasksController < ApplicationController

    def show 
        # byebug
        task = Task.find(params[:id])
        render json: task
    end

    def index 
        # User.find(params[:user_id]).lists
        tasks = List.find(params[:list_id]).tasks

        render json: tasks
    end

    def create 
        task = Task.create!(task_params)
        # task = Task.create!(task_params.merge({list_id: params[:list_id]}))
        # this violates strong params but should work for now.
        render json: task
    end

    def update
        # byebug
        task = Task.find(params[:id])
        task.update!(task_params)
        render json: task
    end

    def destroy 
# if u hit some strang errors it could be due to nexted routes where you need to do something with List like in the index action
        task = Task.find(params[:id])
        task.destroy
        sibling_tasks = task.list.tasks
        sibling_tasks.each_with_index {|task, i| task.update(order: i)}
        render json: sibling_tasks
    end

    private 

    def task_params
        params.require(:task).permit(:list_id, :order, :text, :isDone, :isPinned)
    end

end
