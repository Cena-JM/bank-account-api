# frozen_string_literal: true

module BankAccounts
  class PerformTransaction
    def initialize(amount:, transaction_type:, bank_account_id:, recipient_bank_account_id:)
      @amount = amount.try(:to_f)
      @transaction_type = transaction_type
      @bank_account_id = bank_account_id
      @bank_account = BankAccount.where(id: @bank_account_id).first
      unless recipient_bank_account_id.nil?
        @recipient_bank_account_id = recipient_bank_account_id
        @recipient_bank_account = BankAccount.where(id: @recipient_bank_account_id).first
      end
      @errors = []
    end

    def execute!
      ActiveRecord::Base.transaction do
        AccountTransaction.create!(
          bank_account: @bank_account,
          amount: @amount,
          transaction_type: @transaction_type
        )

        if @transaction_type == 'withdraw'
          @bank_account.update!(balance: @bank_account.balance - @amount)
        elsif @transaction_type == 'deposit'
          @bank_account.update!(balance: @bank_account.balance + @amount)
        elsif @transaction_type == 'send'
          @bank_account.update!(balance: @bank_account.balance - @amount)
          @recipient_bank_account.update!(balance: @recipient_bank_account.balance + @amount)

          SendReceive.create!(
            amount: @amount,
            sender_id: @bank_account_id,
            receiver_id: @recipient_bank_account_id
          )
        end
      end
      @bank_account
    end
  end
end
