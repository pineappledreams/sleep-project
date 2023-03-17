# frozen_string_literal: true

class CalculateSleepTimeJob < ApplicationJob
  queue_as :default

  def perform(clock_in)
    clock_in.update!(sleep_time: (clock_in.clock_out_time - clock_in.clock_in_time).to_i)
  end
end
