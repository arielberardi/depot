# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stores' do
  describe 'GET /index' do
    before { get store_index_path }

    it { expect(response).to have_http_status(:success) }
  end
end
