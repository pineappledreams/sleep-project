# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_many(:friendships).dependent(:destroy) }
  it { is_expected.to have_many(:friends).through(:friendships) }
  it { is_expected.to have_many(:clock_ins).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
end
