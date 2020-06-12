class List < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy


    def update_on_destroy
        sibling_lists = self.user.lists.sort_by { |list| list.order }
        sibling_lists.each_with_index { | list, i | list.update(order: i) }
    end

    def update_after_dnd(start_position, new_position)
        
        
        sibling_lists = (self.user.lists - [self]).sort_by { | list | list.order }

        if start_position < new_position  
            less_than = sibling_lists.select { | list | list.order <= new_position }
            less_than.each_with_index { | list, i| list.update(order: i) }

        elsif start_position > new_position 
            greater_than = sibling_lists.select { | list | list.order >= new_position }
            greater_than.each_with_index { | list, i| list.update(order: i) }
            #  this one is not working 
        end
# get the new_position from destination.index 
        # either return self.user.lists in each or so list.user.lists in render maybe?


    end
end
