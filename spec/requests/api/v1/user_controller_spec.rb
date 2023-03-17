# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users' do
  describe 'GET /api/v1/users' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }

    it 'returns a list of users' do
      get api_v1_users_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/v1/users/:id' do
    let(:user) { create(:user) }

    it 'returns a user' do
      get api_v1_user_path(user)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/v1/users/:id/friend' do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let(:follow_params) { { id: user2.id } }

    it 'creates a new friend' do # rubocop:disable RSpec/MultipleExpectations
      post friend_api_v1_user_path(user2), params: follow_params, as: :json
      expect(response).to have_http_status(:ok)
      expect(user.friends).to include(user2)
    end
  end

  describe 'DELETE /api/v1/users/:id/unfriend' do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:follow_params) { { current_user: user.id, friend: { user_id: user2.id } } }

    before do
      user.friends << user2
    end

    it 'deletes the friend' do # rubocop:disable RSpec/MultipleExpectations
      expect(user.friends).to include(user2)
      delete unfriend_api_v1_user_path(user2), params: follow_params, as: :json
      expect(response).to have_http_status(:ok)
      expect(user.friends).not_to include(user2)
    end
  end
end
