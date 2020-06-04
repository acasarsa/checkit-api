class Api::V1::TasksController < ApplicationController
    before_action :find_taks, only: [:show, :update, :destroy]

    def show 
        render json: task
    end

    def index 
        tasks = Task.all
        render json: tasks
    end

    def create 
        task = Task.create!(task_params)
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
        params.require(:task).permit(:list, :content, :isDone, :isPinned)
    end

    def find_task
        task = Task.find(params[:id])
    end
end
