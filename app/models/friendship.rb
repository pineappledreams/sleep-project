# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :friendship_cannot_be_duplicate
  validate :cannot_friend_yourself

  private

  def friendship_cannot_be_duplicate
    return if user.blank? || friend.blank?

    errors.add(:friendship, 'cannot be duplicate') if user.friends.include?(friend)
  end

  def cannot_friend_yourself
    return if user.blank? || friend.blank?

    errors.add(:friendship, 'cannot be yourself') if user == friend
  end
end
