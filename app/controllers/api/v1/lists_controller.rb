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
        sibling_lists = (list.user.lists - [list]).sort_by { |list| list.order } # subset of lists can't include current list 

        #  check that list[0].order == 0 then set list[0] = 0 
        # lists = User.find(params[:user_id]).lists
        # find current list and update it's order 
        # find all order values sorted in this fashion: a,b => list.order ? 1 : -1 
        # list[0].order + 1 == list[1].order if true return ? // list[1] +1 == list[2] 
# current list from 2 to 6 any of its sibling lists 
        # lists.each_with_index {|list, i | list.update(order: i) }
    # moving forward then start 0 to new position less than or equal to new position
# moving back i start at  anything greater than or equal to new_position 
    end

    def destroy 
#  you should put that logic in your model
        list = List.find(params[:id])
        list.destroy
        sibling_lists = list.user.lists.sort_by { |list| list.order }
        sibling_lists.each_with_index {|list, i | list.update(order: i) }
        render json: sibling_lists, include: [:tasks]
        # sibling_lists = list.user.lists
        # is_consecutive = sibling_lists.sort.each_cons(2).all? { |x,y| y == x + 1 } 
        # if !is_consecutive
            
        # else
        #     sibling_lists
        # end

        # list.user.lists.updateSiblingOrder
        
# have this render the same thing that get user list does 
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
