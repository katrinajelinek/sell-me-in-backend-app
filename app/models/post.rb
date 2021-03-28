class Post < ApplicationRecord
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :images
  belongs_to :user

  validates :title, presence: true, length: { maximum: 50 }
  validates :video_url, presence: true
  validates :location, presence: true
  validates :price, presence: true
  validates :description, length: { maximum: 500 }
end
