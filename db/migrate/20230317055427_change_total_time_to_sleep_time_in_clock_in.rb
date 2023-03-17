# frozen_string_literal: true

class ChangeTotalTimeToSleepTimeInClockIn < ActiveRecord::Migration[7.0]
  def change
    rename_column :clock_ins, :total_time, :sleep_time
  end
end
