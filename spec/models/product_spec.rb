# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  subject(:product) { described_class.new }

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
end
