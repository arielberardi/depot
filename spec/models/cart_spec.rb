# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart do
  describe 'validation' do
    it { is_expected.to have_many(:line_items) }
  end
end
