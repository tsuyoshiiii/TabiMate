class PostComment < ApplicationRecord
    belongs_to :member
    belongs_to :post
    belongs_to :member

    validates :comment, presence: true
end
