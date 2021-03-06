class Api::V1::ListsController < ApplicationController

    def show 
        list = List.find(params[:id])
        render json: list, include: [:tasks]
    end

    def index 
      # byebug
        lists = User.find(params[:user_id]).lists
        render json: lists, include: [:tasks]
    end

    def create 
        list = List.create!(list_params)
        render json: list, include: [:tasks]
    end

    def update
        list = List.find(params[:id])
        list.update(list_params)
        render json: list, include: [:tasks]
    end

    def update_order
        list = List.find(params[:id])
        start_position = list.order 
        new_position = params[:order]
        ordered = list.update_list_order(start_position, new_position)
        render json: ordered, include: [:tasks]
    end

    def destroy
        list = List.find(params[:id])
        list.destroy
        remaining_lists = list.reorder_after_destroy
        render json: remaining_lists, include: [:tasks]
    end


    private 

    def list_params
        params.require(:list).permit(:user_id, :title, :order)
    end

end
