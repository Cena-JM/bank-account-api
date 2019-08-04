# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankAccount, type: :model do
  subject { build(:bank_account) }

  describe 'validations' do
    context 'attributes' do
      it { expect(subject).to be_valid }
    end

    context 'presence' do
      it { should validate_presence_of :client }
      it { should validate_presence_of :account_number }
      it { should validate_presence_of :balance }
    end

    context 'format' do
      it { should_not allow_value('blah').for(:balance) }
    end
  end

  describe 'associations' do
    it { should belong(:client) }
    it { should have_many(:account_transactions).dependent(:destroy) }
    it { should have_many(:recipients).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it do
      should have_many(:recipients)
        .class_name(:SendReceive)
        .with_foreign_key(:receiver_id)
        .dependent(:destroy)
    end
    it do
      should have_many(:sources)
        .class_name(:SendReceive)
        .with_foreign_key(:sender_id)
        .dependent(:destroy)
    end
    it do
      should have_many(:receivers)
        .through(:recipients)
        .source(:receiver)
    end
    it do
      should have_many(:senders)
        .through(:sources)
        .source(:sender)
    end
  end
end
