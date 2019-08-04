# frozen_string_literal: true

module Api
  module V1
    class BankAccountsController < ApplicationController
      def index
        @bank_accounts = BankAccount.all
        json_response(@bank_accounts)
      end

      def show
        @bank_account = BankAccount.find(params[:id])
        json_response(@bank_account)
      end

      def new
        @bank_account = BankAccount.new
      end

      def create
        @bank_account = BankAccount.create(bank_account_params)
        if @bank_account.save
          json_response(@bank_account, :created)
        else
          json_response(@bank_account, :unprocessable_entity)
        end
      end

      def update
        @bank_account = BankAccount.find(params[:id])
        @bank_account.update(bank_account_params)
        head :no_content
      end

      def destroy
        @bank_account = BankAccount.find(params[:id])
        @bank_account.destroy
        head :no_content
      end

      private

      def bank_account_params
        params.permit(:client_id, :account_number, :balance)
      end
    end
  end
end
