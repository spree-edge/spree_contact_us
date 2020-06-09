# frozen_string_literal: true

module Spree
  class InquiryMailer < BaseMailer
    def notification(inquiry)
      @inquiry = inquiry
      @site_name = site_name

      mail(
        to: from_address,
        reply_to: inquiry.email,
        from: from_address,
        subject: "#{site_name}: #{inquiry.inquiry_type}"
      )
    end

    def confirmation(inquiry)
      @inquiry = inquiry
      @site_name = site_name

      mail(
        to: inquiry.email,
        reply_to: from_address,
        from: from_address,
        subject: "#{site_name}: #{inquiry.inquiry_type}"
      )
    end

    private

    def site_name
      Spree::Store.current.name
    end
  end
end
