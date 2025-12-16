class GroupMember < ApplicationRecord
  belongs_to :member
  belongs_to :group
  enum status: { pending: 0, approved: 1, rejected: 2 }
end
