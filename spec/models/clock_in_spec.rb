# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClockIn do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:clock_in_time) }
  it { is_expected.to validate_presence_of(:clock_out_time) }

  it 'runs CalculateSleepTimeJob after create' do
    ActiveJob::Base.queue_adapter = :test
    create(:clock_in)
    expect(CalculateSleepTimeJob).to have_been_enqueued
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
