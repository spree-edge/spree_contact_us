# frozen_string_literal: true

class RenameInquiryToNamespace < ActiveRecord::Migration[4.2]
  def change
    rename_table :inquiries, :spree_inquiries
  end
end
