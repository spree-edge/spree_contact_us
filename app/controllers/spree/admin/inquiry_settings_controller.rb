# frozen_string_literal: true

module Spree
  module Admin
    class InquirySettingsController < Spree::Admin::BaseController
      def update
        set_captcha_params
        set_inquiry_types

        respond_to do |format|
          format.html { redirect_to admin_inquiry_settings_path }
        end
      end

      private

      def set_captcha_params
        params[:captcha] ||= {}

        Spree::ContactUsConfiguration.set(
          use_captcha: params[:captcha][:use_captcha],
          use_honeypot: params[:captcha][:use_honeypot],
          recaptcha_public_key: params[:captcha][:recaptcha_public_key],
          recaptcha_private_key: params[:captcha][:recaptcha_private_key],
          recaptcha_theme: params[:captcha][:recaptcha_theme]
        )
      end

      def set_inquiry_types
        inquiry_types = params[:inquiry_types].split(/,\s*/).map(&:to_sym)
        Spree::ContactUsConfiguration.set(inquiry_types: inquiry_types)
      end
    end
  end
end
