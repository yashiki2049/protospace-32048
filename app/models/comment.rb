class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype
  has_one_attached :image

  validates :text, presence: true
end
