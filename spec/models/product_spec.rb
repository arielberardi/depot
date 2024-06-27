# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:image_url) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }

    describe 'image_url format' do
      it { is_expected.to allow_value('image.gif').for(:image_url) }
      it { is_expected.to allow_value('image.jpg').for(:image_url) }
      it { is_expected.to allow_value('image.png').for(:image_url) }
      it { is_expected.to allow_value('image.jpeg').for(:image_url) }
      it { is_expected.not_to allow_value('image.bmp').for(:image_url) }
      it { is_expected.not_to allow_value('image.txt').for(:image_url) }
      it { is_expected.not_to allow_value('image').for(:image_url) }
      it { is_expected.not_to allow_value('').for(:image_url) }
      it { is_expected.not_to allow_value('image.png.txt').for(:image_url) }
    end
  end

  describe 'relations' do
    it { is_expected.to have_many(:line_items) }
  end

  describe 'before_destroy' do
    let!(:product) { create(:product) }

    it { expect { product.destroy }.to change(described_class, :count).by(-1) }

    context 'when product is on a line_item' do
      before { create(:line_item, product:) }

      it { expect { product.destroy }.not_to change(described_class, :count) }
    end
  end
end
