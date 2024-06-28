# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :line_items, dependent: nil

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :image_url, :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
    with: /\.(gif|jpg|jpeg|png)\z/i,
    message: I18n.t('product.errors.image_format')
  }

  private

  def ensure_not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, I18n.t('product.errors.destroying_with_dependants'))
    throw :abort
  end
end
