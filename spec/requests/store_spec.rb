# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Stores' do
  describe 'GET /index' do
    before do
      create_list(:product, 2)
      get store_index_path
    end

    it { expect(response).to have_http_status(:success) }

    describe 'shows the list of products' do
      it { expect(response.body).to include(Product.first.title) }
      it { expect(response.body).to include(Product.last.title) }
    end
  end
end
