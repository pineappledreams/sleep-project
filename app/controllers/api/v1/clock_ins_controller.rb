# frozen_string_literal: true

module Api
  module V1
    class ClockInsController < ApplicationController
      def index
        @clock_ins = current_user.clock_ins.order(:created_at)
        render json: @clock_ins
      end

      def create
        @clock_in = current_user.clock_ins.new(clock_in_params)
        if @clock_in.save
          render json: @clock_in, status: :created
        else
          render json: @clock_in.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @clock_in = current_user.clock_ins.find(params[:id])
        @clock_in.destroy
        head :no_content
      end

      private

      def clock_in_params
        params.require(:clock_in).permit(:clock_in_time, :clock_out_time)
      end
    end
  end
end
