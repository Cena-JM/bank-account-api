# frozen_string_literal: true

module Api
  module V1
    class AccountTransactionsController < ApplicationController
      def index
        @account_transactions = AccountTransaction.all
        json_response(@account_transactions)
      end

      def show
        @account_transaction = AccountTransaction.find(params[:id])
        json_response(@account_transaction)
      end

      def new
        @account_transaction = AccountTransaction.new
      end

      def create
        amount = params[:amount]
        transaction_type = params[:transaction_type]
        bank_account_id = params[:bank_account_id]
        recipient_bank_account_id = params[:recipient_bank_account_id]

        errors = ::BankAccounts::ValidateNewTransaction.new(
          amount: amount,
          transaction_type: transaction_type,
          bank_account_id: bank_account_id,
          recipient_bank_account_id: recipient_bank_account_id
        ).execute!

        if !errors.empty?
          json_response(errors, :unprocessable_entity)
        else
          bank_account = ::BankAccounts::PerformTransaction.new(
            amount: amount,
            transaction_type: transaction_type,
            bank_account_id: bank_account_id,
            recipient_bank_account_id: recipient_bank_account_id
          ).execute!
          receiver = bank_account
          receiver = BankAccount.find(params[:recipient_bank_account_id]) if transaction_type == 'send'
          json_response([{ 'sender_balance': bank_account.balance },
                         { 'receiver_balance': receiver.balance }])
        end
      end
    end
  end
end
