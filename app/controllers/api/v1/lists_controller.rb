class Api::V1::ListsController < ApplicationController
    before_action :find_list, only: [:show, :update, :destroy]

    def show 
        render json: list, include: [:tasks]
    end

    def index 
        lists = User.find(params[:user_id]).lists
        render json: lists, include: [:tasks]
    end

    def create 
        list = List.create!(list_params)
        render json: list, include: [:tasks]
    end

    def update
        list.update(list_params)
        render json: list, include: [:tasks]
    end

    def destroy 
        list.destroy
    end

    private 

    def list_params
        params.require(:list).permit(:user, :title)
    end

    def find_list
        list = List.find(params[:id])
    end
end
