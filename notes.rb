current_list.user.lists - [current_list]

new_position = 2 # equal to destination.index
siblings = current_list.user.lists - [current_list]

siblings.pluck(:order)

sorted = siblings.sort_by { | l | l.order }

current_list.order
sorted.pluck(:order)
sorted.select { | l | l.order <= current_list.order }
sorted.select { |l| l.order <= new_position }

less_than = sorted.select { |l| l.order <= new_position }

less_than.each_with_index { |l, i| l.update(order: i)}
current_list.save

# current_list.user.lists.pluck(:order)

list.update(list_params) 
updated = (greater_than + [list]).sort_by{ | list | list.updated_at }.reverse
updated.sort_by{ |l| l.order }

    # if greater_than[new_position] === new_position ? greater_than[new_position + 1] : return el

greater_than.each do |list|  
    list.order
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


# add somse logic to find lists siblings all the list that have same user take an order check to  find if misssing order and adjust the thigns that follow by -1 
# that should trigger a re-render 
# list.user.lists 
# do the logic in the destory ? 
# add an instance method to list model update sbuilng order and call taht before u destroy it. 
# 
#  if order is look at list.user.lists.order 


# can i make a route that goes to the current listID on the back: √
# i want to return the old list array reordered and the new list array reordered  ?
# render json: start_list, include: [:tasks], end_list, include: [:tasks]  ?
# i will first save the task to a var update it's list_id find the old list's tasks sort them then reset their order to index 
# take task out of list 1 for good. => update list_id means that you need to update the list state of list 1 and list 2 
# on back if you change the list_id it's going to just remove it from the list but it doesn't trigger the destroy action . 


    # // updatedTasks => setLists(lists.map(list => list.id === listID ? { ...list, tasks: updatedTasks } : list))
    # // setLists(lists.map(list => list.id === finishID ? { ...list, tasks: updatedTasks } : list))
    # // can i make a route that goes to the current listID on the back: 
    # // i want to return the old list array reordered and the new list array reordered 
    # // render json: start_list, include: [:tasks], end_list, include: [:tasks] 
    # // i will first save the task to a var update it's list_id find the old list's tasks sort them then reset their order to index 
    # // take task out of list 1 for good. => update list_id means that you need to update the list state of list 1 and list 2 
    # // on back if you change the list_id it's going to just remove it from the list but it doesn't trigger the destroy action . 
    # // if save it on front. then delete it on back and then try to update that lists id i won't be able to get there, if i update the id first 
    # // setLists(lists.map(list => list.id === listID ? { ...list, tasks: updatedTasks } : list))