class Post < ApplicationRecord
  has_many :post_comments, dependent: :destroy
  has_one_attached :image
  belongs_to :member
  attribute :title, :string
  attribute :body, :text
  validates :title, {presence: true}
  validates :body, {presence: true}
end
