# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendReceive, type: :model do
  subject { build(:send_receive) }

  describe 'validations' do
    context 'attributes' do
      it { expect(subject).to be_valid }
    end

    context 'presence' do
      it { should validate_presence_of :sender }
      it { should validate_presence_of :receiver }
    end

    context 'format' do
      it { should_not allow_value(:sender_id).for(:sender) }
      it { should_not allow_value(:receiver_id).for(:receiver) }
      it { should allow_value(:receiver_id).for(:sender) }
      it { should allow_value(:sender_id).for(:receiver) }
    end
  end

  describe 'associations' do
    it { should belong(:sender).class_name(:BankAccount) }
    it { should belong(:bank_account).class_name(:BankAccount) }
  end
end
