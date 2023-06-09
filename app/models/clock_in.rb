# frozen_string_literal: true

class ClockIn < ApplicationRecord
  belongs_to :user

  validates :clock_in_time, presence: true
  validates :clock_out_time, presence: true

  validate :clock_out_time_cannot_be_before_clock_in_time

  after_create { CalculateSleepTimeJob.perform_later(self) }

  private

  def clock_out_time_cannot_be_before_clock_in_time
    return if clock_in_time.blank? || clock_out_time.blank?

    errors.add(:clock_out_time, 'cannot be before clock in time') if clock_out_time < clock_in_time
  end
end
