# frozen_string_literal: true

class AddViewportSizeToInquiries < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_inquiries, :client_viewport_size, :string, length: 15
  end
end
