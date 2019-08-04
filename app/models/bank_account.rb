# frozen_string_literal: true

class BankAccount < ApplicationRecord
  belongs_to :client
  has_many :account_transactions, dependent: :destroy
  has_many :recipients, foreign_key: 'receiver_id', class_name: 'SendReceive', dependent: :destroy
  has_many :sources, foreign_key: 'sender_id', class_name: 'SendReceive', dependent: :destroy
  has_many :receivers, through: :recipients, source: :receiver
  has_many :senders, through: :sources, source: :sender

  validates :client, presence: true
  validates :account_number, presence: true, uniqueness: true
  validates :balance, presence: true, numericality: true

  before_validation :load_defaults

  def load_defaults
    self.balance = 0.00 if new_record?
  end

  def to_s
    account_number
  end
end
