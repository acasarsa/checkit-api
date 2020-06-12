class Api::V1::ListsController < ApplicationController

    def show 
        list = List.find(params[:id])
        render json: list, include: [:tasks]
    end

    def index 
        lists = User.find(params[:user_id]).lists
        render json: lists, include: [:tasks]
        # render json: lists.sort_by{|list| list.order}, include: [:tasks]
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
        # start_position = list.order
        # list.update_after_dnd(start_position, new_position)
        sibling_lists = (list.user.lists - [list]).sort_by { | list | list.order }
        # byebug
        if start_position < new_position  
            # byebug
            less_than = sibling_lists.select { | list | list.order <= new_position }
            less_than.each_with_index { | list, i| list.update(order: i) }
            

        elsif start_position > new_position 
            byebug
            greater_than = sibling_lists.select { | list | list.order >= new_position }
            greater_than.each_with_index { | list, i| list.update(order: i) }
            # in bye bug did some of this and found that when i do line 42 it changed the 1 el higher than new_pos to index 0!

            # this one is all sorts of messed up but no idea why?
        end

        
        list.update(list_params)
        reordered_lists = User.find(params[:user_id]).lists
        render json: reordered_lists, include: [:tasks]
    end
    # def update_order
    #     list = List.find(params[:id])
    #     # start_position = list.order
    #     list.update_after_dnd(new_position, list_params)
    #     reordered_lists = list.user.lists
    #     render json: reordered_lists, include: [:tasks]
    # end
        # list.update(list_params) #can i use list params or will this be messed up because i'm passing someting that is not going into this. 
        # sibling_lists = (list.user.lists - [list]).sort_by { |list| list.order } # subset of lists can't include current list 
        #  check that list[0].order == 0 then set list[0] = 0 
        # lists = User.find(params[:user_id]).lists
        # find current list and update it's order 
        # find all order values sorted in this fashion: a,b => list.order ? 1 : -1 
        # list[0].order + 1 == list[1].order if true return ? // list[1] +1 == list[2] 
# current list from 2 to 6 any of its sibling lists 
        # lists.each_with_index {|list, i | list.update(order: i) }
    # moving forward then start 0 to new position less than or equal to new position
# moving back i start at  anything greater than or equal to new_position 
    

    def destroy 
#  you should put that logic in your model
        list = List.find(params[:id])
        list.destroy
        remaining_lists = list.update_on_destroy
        render json: remaining_lists, include: [:tasks]
        
    end
# add somse logic to find lists siblings all the list that have same user take an order check to  find if misssing order and adjust the thigns that follow by -1 
# that should trigger a re-render 
# list.user.lists 
# do the logic in the destory ? 
# add an instance method to list model update sbuilng order and call taht before u destroy it. 
# 
#  if order is look at list.user.lists.order 

    private 

    def list_params
        params.require(:list).permit(:user_id, :title, :order)
    end

end
