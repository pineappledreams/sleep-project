# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CalculateSleepTimeJob do
  describe '#perform' do
    let(:clock_in) { create(:clock_in) }

    it 'updates the sleep time' do
      expect { described_class.perform_now(clock_in) }
        .to change { clock_in.reload.sleep_time }
        .from(nil)
        .to(8.hours.to_i)
    end
  end
end
