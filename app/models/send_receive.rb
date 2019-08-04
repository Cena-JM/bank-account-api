# frozen_string_literal: true

class SendReceive < ApplicationRecord
  belongs_to :sender, class_name: 'BankAccount'
  belongs_to :receiver, class_name: 'BankAccount'

  validates :sender, presence: true
  validates :receiver, presence: true
  validates :amount, presence: true
  validate :not_self

  private

  def not_self
    errors.add(:sender, 'Can\'t be equal to receiver') if sender == receiver
  end
end
