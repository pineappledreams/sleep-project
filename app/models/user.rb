# frozen_string_literal: true

class User < ApplicationRecord
  has_many :clock_ins, dependent: :destroy
  has_many :friends, through: :friendships,
                     class_name: 'User',
                     association_foreign_key: :friend_id
end
