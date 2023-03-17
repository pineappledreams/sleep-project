# frozen_string_literal: true

class AddTotalTimeToClockIn < ActiveRecord::Migration[7.0]
  def change
    add_column :clock_ins, :total_time, :integer
  end
end
