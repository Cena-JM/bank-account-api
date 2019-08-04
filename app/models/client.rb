# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :bank_accounts, dependent: :destroy

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :middle_name, presence: true, length: { maximum: 50 }
  validates :address, presence: true, length: { maximum: 50 }
  validates :gender, presence: true, length: { maximum: 10 }
  validates :date_of_birth, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :client_number, presence: true, uniqueness: true

  before_save :formart_name

  def formart_name
    self.first_name = first_name.upcase
    self.last_name = last_name.upcase
    self.middle_name = middle_name.upcase
  end

  def to_s
    "#{last_name}, #{first_name} #{middle_name}"
  end
end
