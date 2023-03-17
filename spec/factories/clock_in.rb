# frozen_string_literal: true

FactoryBot.define do
  factory :clock_in do
    user
    clock_in_time { 8.hours.ago }
    clock_out_time { Time.zone.now }

    trait :with_sleep_time do
      sleep_time { (clock_out_time - clock_in_time).to_i }
    end

    trait :random do
      clock_in_time { rand(1..12).days.ago.at_midnight }
      clock_out_time { clock_in_time + rand(1..12).hours }
    end
  end
end
