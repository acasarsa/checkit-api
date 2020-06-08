class Api::V1::TasksController < ApplicationController
    before_action :find_taks, only: [:show, :update, :destroy]

    # def show 
    #     render json: task
    # end

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
        task.update(task_params)
        render json: task
    end

    def destroy 
        task.destroy
    end

    private 

    def task_params
        params.require(:task).permit(:list_id, :text, :isDone, :isPinned)
    end

    def find_task
        task = Task.find(params[:id])
    end
end
