# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ClockIns' do
  describe 'POST /api/v1/clock_ins' do
    let(:user) { create(:user) }
    let(:clock_in_params) { { clock_in: { clock_in_time: 8.hours.ago, clock_out_time: Time.zone.now } } }

    it 'creates a new clock in' do
      post api_v1_user_clock_ins_path(user), params: clock_in_params, as: :json
      expect(response).to have_http_status(:created)
    end
  end

  describe 'DELETE /api/v1/clock_ins/:id' do
    let(:user) { create(:user) }
    let!(:clock_in) { create(:clock_in, user:) }

    it 'deletes a clock in' do # rubocop:disable RSpec/MultipleExpectations
      delete api_v1_user_clock_in_path(user, clock_in)
      expect(response).to have_http_status(:no_content)
      expect(user.clock_ins).not_to include(clock_in)
    end
  end
end
