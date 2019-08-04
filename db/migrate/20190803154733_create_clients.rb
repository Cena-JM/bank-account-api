# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :email
      t.string :address
      t.string :gender
      t.date :date_of_birth
      t.string :client_number

      t.timestamps
    end
  end
end
