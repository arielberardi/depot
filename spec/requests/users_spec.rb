# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/users' do
  let!(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:user) }

  describe 'GET /index' do
    before { get users_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /show' do
    before { get user_path(user) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /new' do
    before { get new_user_path }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'GET /edit' do
    before { get edit_user_path(user) }

    it { expect(response).to have_http_status(:success) }
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        expect do
          post users_path, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirects to the created user' do
        post users_path, params: { user: valid_attributes }
        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) { { name: Faker::Name.name } }

      before { patch user_path(user), params: { user: new_attributes } }

      it { expect(User.find(user.id).name).to eq(new_attributes[:name]) }
      it { expect(response).to redirect_to(users_url) }
    end
  end

  describe 'DELETE /destroy' do
    before { delete user_path(user) }

    it { expect(response).to redirect_to(users_url) }
  end
end
