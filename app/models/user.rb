class User < ApplicationRecord
    has_one :this_week
    has_one :note
    has_many :lists, dependent: :destroy
    has_many :tasks, through: :lists
end
