class Product < ApplicationRecord
  validates :title, :image_url, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|jpeg|png)\z}i,
    message: 'must be an URL for GIF, JPEG, or PNG image.'
  }
end
