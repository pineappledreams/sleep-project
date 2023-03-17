# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include ActionView::Helpers::DateHelper

      before_action :set_user, only: %i[show destroy friend unfriend friends sleep_records]

      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user.destroy
        head :no_content
      end

      def friend
        current_user.friends << @user
        render json: @user
      end

      def unfriend
        current_user.friends.delete(@user)
        render json: @user
      end

      def friends
        @friends = current_user.friends
        render json: @friends
      end

      def sleep_records
        @sleep_records = current_user.friends_with_sleep_records.map do |clock_in|
          {
            name: clock_in.user.name,
            clock_in_time: clock_in.clock_in_time,
            clock_out_time: clock_in.clock_out_time,
            sleep_time: distance_of_time_in_words(clock_in.sleep_time, 0, include_seconds: true)
          }
        end
        render json: @sleep_records
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name)
      end
    end
  end
end
