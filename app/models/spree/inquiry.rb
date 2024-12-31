# frozen_string_literal: true

module Spree
  class Inquiry < Spree::Base
    INQUIRY_TYPES = ['Support', 'Sales', 'Website Issue', 'Suggestion', 'Other'].freeze

    validates :name, :message, presence: true
    validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

    # after_save do
    #   InquiryMailer.notification(self).deliver # to submitter
    #   InquiryMailer.confirmation(self).deliver # to admin
    # end
  end
end
