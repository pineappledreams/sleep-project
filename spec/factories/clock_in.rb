# frozen_string_literal: true

FactoryBot.define do
  factory :clock_in do
    user
    clock_in_time { 8.hours.ago }
    clock_out_time { Time.zone.now }
  end
end
