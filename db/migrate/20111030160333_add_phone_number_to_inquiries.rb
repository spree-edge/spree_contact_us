# frozen_string_literal: true

class AddPhoneNumberToInquiries < ActiveRecord::Migration[4.2]
  def self.up
    add_column :inquiries, :phone_number, :string
  end

  def self.down
    remove_column :inquiries, :phone_number
  end
end
