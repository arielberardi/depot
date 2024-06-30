# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItem do
  describe 'validations' do
    it { is_expected.to belong_to(:product) }
  end
end
