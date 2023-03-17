# frozen_string_literal: true

class User < ApplicationRecord
  has_many :clock_ins, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships,
                     class_name: 'User',
                     foreign_key: :friend_id

  validates :name, presence: true
end
