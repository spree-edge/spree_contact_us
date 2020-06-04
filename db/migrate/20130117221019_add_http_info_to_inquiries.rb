# frozen_string_literal: true

class AddHttpInfoToInquiries < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_inquiries, :http_user_agent, :string
    add_column :spree_inquiries, :http_remote_addr, :string
  end
end
