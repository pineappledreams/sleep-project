# frozen_string_literal: true

class User < ApplicationRecord
  has_many :clock_ins, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships,
                     class_name: 'User',
                     foreign_key: :friend_id

  validates :name, presence: true

  def friends_with_sleep_records(days = 7)
    ClockIn.includes(:user).where(user_id: friends.ids,
                                  clock_ins: { clock_in_time: days.days.ago..Time.zone.now }).order('sleep_time DESC')
  end
end
