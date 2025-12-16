class Group < ApplicationRecord
  belongs_to :owner, class_name: 'Member', foreign_key: 'owner_id'

  has_many :group_members, dependent: :destroy
  has_many :members, through: :group_members

  validates :name, presence: true, uniqueness: true
  validates :introduction, presence: true
end
