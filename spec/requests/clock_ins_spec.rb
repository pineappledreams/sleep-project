# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ClockIns' do
  describe 'GET /index' do
    it 'returns http success' do
      get '/clock_ins/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/clock_ins/create'
      expect(response).to have_http_status(:success)
    end
  end
end
