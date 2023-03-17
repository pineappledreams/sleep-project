# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:friend) }

  describe '#friendship_cannot_be_duplicate' do
    let(:user) { create(:user) }
    let(:friend) { create(:user) }
    let(:friendship) { build(:friendship, user:, friend:) }

    context 'when friendship is duplicate' do
      before { create(:friendship, user:, friend:) }

      it 'adds an error to the friendship' do
        friendship.valid?
        expect(friendship.errors[:friendship]).to include('cannot be duplicate')
      end
    end

    context 'when friendship is not duplicate' do
      it 'does not add an error to the friendship' do
        friendship.valid?
        expect(friendship.errors[:friendship]).to be_empty
      end
    end
  end

  describe '#cannot_friend_yourself' do
    let(:user) { create(:user) }
    let(:friendship) { build(:friendship, user:, friend: user) }

    context 'when friendship is with yourself' do
      it 'adds an error to the friendship' do
        friendship.valid?
        expect(friendship.errors[:friendship]).to include('cannot be yourself')
      end
    end

    context 'when friendship is not with yourself' do
      let(:friend) { create(:user) }
      let(:friendship) { build(:friendship, user:, friend:) }

      it 'does not add an error to the friendship' do
        friendship.valid?
        expect(friendship.errors[:friendship]).to be_empty
      end
    end
  end
end
