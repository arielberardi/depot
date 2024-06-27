# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/carts' do
  describe 'GET /index' do
    before { get carts_url }

    it { expect(reponse).to be_successful }
  end
end
