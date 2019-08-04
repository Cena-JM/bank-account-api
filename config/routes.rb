# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :clients
      resources :bank_accounts
      resources :account_transactions
    end
  end
end
