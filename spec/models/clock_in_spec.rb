# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClockIn do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:clock_in_time) }
  it { is_expected.to validate_presence_of(:clock_out_time) }

  describe '#clock_in_time_cannot_be_in_the_future' do
    let(:clock_in) { build(:clock_in, clock_in_time:) }

    context 'when clock in time is in the future' do
      let(:clock_in_time) { 1.day.from_now }

      it 'adds an error to the clock in time' do
        clock_in.valid?
        expect(clock_in.errors[:clock_in_time]).to include('cannot be in the future')
      end
    end

    context 'when clock in time is in the past' do
      let(:clock_in_time) { 1.day.ago }

      it 'does not add an error to the clock in time' do
        clock_in.valid?
        expect(clock_in.errors[:clock_in_time]).to be_empty
      end
    end
  end

  describe '#clock_out_time_cannot_be_in_the_future' do
    let(:clock_in) { build(:clock_in, clock_out_time:) }

    context 'when clock out time is in the future' do
      let(:clock_out_time) { 1.day.from_now }

      it 'adds an error to the clock out time' do
        clock_in.valid?
        expect(clock_in.errors[:clock_out_time]).to include('cannot be in the future')
      end
    end

    context 'when clock out time is in the past' do
      let(:clock_out_time) { 1.hour.ago }

      it 'does not add an error to the clock out time' do
        clock_in.valid?
        expect(clock_in.errors[:clock_out_time]).to be_empty
      end
    end
  end

  describe '#clock_out_time_cannot_be_before_clock_in_time' do
    let(:clock_in) { build(:clock_in, clock_in_time:, clock_out_time:) }

    context 'when clock out time is before clock in time' do
      let(:clock_in_time) { 1.day.ago }
      let(:clock_out_time) { 2.days.ago }

      it 'adds an error to the clock out time' do
        clock_in.valid?
        expect(clock_in.errors[:clock_out_time]).to include('cannot be before clock in time')
      end
    end

    context 'when clock out time is after clock in time' do
      let(:clock_in_time) { 1.day.ago }
      let(:clock_out_time) { Time.zone.now }

      it 'does not add an error to the clock out time' do
        clock_in.valid?
        expect(clock_in.errors[:clock_out_time]).to be_empty
      end
    end
  end
end
