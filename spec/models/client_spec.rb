# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  subject { build(:client) }

  describe 'validations' do
    context 'attributes' do
      it { expect(subject).to be_valid }
    end

    context 'presence' do
      it { should validate_presence_of :first_name }
      it { should validate_presence_of :last_name }
      it { should validate_presence_of :middle_name }
      it { should validate_presence_of :address }
      it { should validate_presence_of :date_of_birth }
      it { should validate_presence_of :gender }
      it { should validate_presence_of :email }
    end

    context 'length' do
      it { should validate_length_of(:first_name) .is_at_most(50) }
      it { should validate_length_of(:last_name) .is_at_most(50) }
      it { should validate_length_of(:middle_name) .is_at_most(50) }
      it { should validate_length_of(:address) .is_at_most(50) }
      it { should validate_length_of(:gender) .is_at_most(10) }
    end

    context 'format' do
      it { should allow_value('dhh@nonopinionated.com').for(:email) }
      it { should_not allow_value('base@example').for(:email) }
      it { should_not allow_value('blah').for(:email) }
      it { should_not allow_value('blah').for(:date_of_birth) }
      it { should_not allow_value('02').for(:date_of_birth) }
    end
  end

  describe 'associations' do
    it { should have_many(:bank_accounts).dependent(:destroy) }
  end
end
