class List < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy


    def reorder_after_destroy
        sibling_lists = self.user.lists.sort_by { |list| list.order }
        sibling_lists.each_with_index { | list, i | list.update(order: i) }
        
    end

    # working on alternative 
    # def reorder_siblings(start_position, new_position)
        
    #     sibling_lists = (self.user.lists - [self]).sort_by { | list | list.order }

    #     if start_position < new_position  
    #         less_than = sibling_lists.select { | list | list.order <= new_position }
    #         less_than.each_with_index { | list, i| list.update(order: i) }

    #     elsif start_position > new_position 
    #         greater_than = sibling_lists.select { | list | list.order >= new_position }
    #         greater_than.each.with_index(new_position) { |list, i| list.update(order: i + 1)}

    #     end

    # end

    def update_list_order(start_position, new_position)
        lists = self.user.lists
        sorted_lists = lists.sort_by{ | list | list.order }
        sliced_list = sorted_lists.slice!(start_position, 1)

        recombined = (sorted_lists.insert(new_position, sliced_list)).flatten
        reordered_lists = recombined.each_with_index { | list, i | list.update(order: i) }

    end
end

# slice at index x 