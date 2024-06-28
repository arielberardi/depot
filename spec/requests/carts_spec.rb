# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/carts' do
  describe 'GET /show' do
    let(:cart) { create(:cart) }

    before { get cart_path(cart) }

    it { expect(response).to be_successful }
  end
end
