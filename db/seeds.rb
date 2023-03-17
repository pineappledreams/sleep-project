# frozen_string_literal: true

require 'ffaker'

ActiveRecord::Base.transaction do
  10.times do
    user = User.create!(name: FFaker::Name.name)
    (1..10).each do |times|
      clock_in_time = times.days.ago.at_midnight
      clock_out_time = clock_in_time + rand(1..12).hours + rand(1..60).minutes
      user.clock_ins.create!(clock_in_time:, clock_out_time:,
                             sleep_time: (clock_out_time - clock_in_time).to_i)
    end
  end

  User.first(5).each do |user|
    User.last(5).each do |friend|
      user.friends << friend
    end
  end
end
