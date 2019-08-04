# frozen_string_literal: true

class CreateSendReceives < ActiveRecord::Migration[5.2]
  def change
    create_table :send_receives do |t|
      t.references :sender
      t.references :receiver
      t.string :amount

      t.timestamps
    end
    add_foreign_key :send_receives, :bank_account, column: :sender_id
    add_foreign_key :send_receives, :bank_account, column: :receiver_id
  end
end
