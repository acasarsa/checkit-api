class Api::V1::ListsController < ApplicationController
    before_action :find_list, only: [:show, :update, :destroy]

    def show 
        render json: list
    end

    def index 
        lists = List.all
        render json: lists
    end

    def create 
        list = List.create!(list_params)
        render json: list
    end

    def update
        list.update(list_params)
        render json: list
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
