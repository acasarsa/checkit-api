class User < ApplicationRecord
    has_one :this_week
    has_one :note
    has_many :lists
end
