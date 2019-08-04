# frozen_string_literal: true

module BankAccounts
  class ValidateNewTransaction
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
      validate_existance_of_account!

      if (@transaction_type == 'withdraw' || @transaction_type == 'send') && @bank_account.present?
        validate_withdrawal!
      end

      @errors
    end

    private

    def validate_withdrawal!
      @errors << 'Not enough funds' if @bank_account.balance - @amount < 0.00
    end

    def validate_existance_of_account!
      @errors << 'Account not found' if @bank_account.blank?
      if @transaction_type == 'send'
        @errors << 'Recipient account not found' if @recipient_bank_account.blank?
      end
    end
  end
end
