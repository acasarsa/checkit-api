class List < ApplicationRecord
    belongs_to :user
    has_many :tasks, dependent: :destroy


    def self.update_order
        
    end
end
