class List < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy


    def update_on_destroy
        sibling_lists = self.user.lists.sort_by { |list| list.order }
        sibling_lists.each_with_index { | list, i | list.update(order: i) }
    end

    def update_after_dnd(new_position)
        # get the new_position from destination.index 
        start_position = self.order 
        self.update(order: new_position)
        # either return self.user.lists in each or so list.user.lists in render maybe?
        sibling_lists = self.user.lists - [self]
        sorted = sibling_lists.sort_by { | list | list.order }

        if start_position < new_position  
            less_than = sorted.select { | list | list.order <= new_position }
            less_than.each_with_index { | list, i| list.update(order: i) }

        elsif start_position > new_position 
            greater_than = sorted.select { | list | list.order >= new_position }
            greater_than.each_with_index { | list, i| list.update(order: i) }
        end

    end
end
