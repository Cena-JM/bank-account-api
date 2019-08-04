# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountTransaction, type: :model do
  subject { build(:account_transaction) }

  describe 'validations' do
    context 'attributes' do
      it { expect(subject).to be_valid }
    end

    context 'presence' do
      it { should validate_presence_of :bank_account }
      it { should validate_presence_of :amount }
      it { should validate_presence_of :transaction_type }
    end

    context 'format' do
      it { should_not allow_value('blah').for(:balance) }
      it { should_not allow_value('blah').for(:transaction_type) }
    end
  end

  describe 'associations' do
    it { should belong(:bank_account) }
  end
end
