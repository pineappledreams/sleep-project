# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: %i[index show create destroy] do
        resources :clock_ins, only: %i[index create destroy]

        member do
          post :friend
          delete :unfriend
          get :sleep_records
        end
      end
    end
  end
end
