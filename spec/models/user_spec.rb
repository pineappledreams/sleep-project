# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_many(:friendships).dependent(:destroy) }
  it { is_expected.to have_many(:friends).through(:friendships) }
  it { is_expected.to have_many(:clock_ins).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }

  describe '#friends_with_sleep_records' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }

    before do
      create(:friendship, user:, friend:)
      create_list(:clock_in, 10, user: friend)
    end

    it 'returns the friends with sleep records' do
      expect(user.friends_with_sleep_records).to eq(friend.clock_ins.order('sleep_time DESC'))
    end
  end
end
