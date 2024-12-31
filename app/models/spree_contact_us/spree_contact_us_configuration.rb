# frozen_string_literal: true

module SpreeContactUs
  class SpreeContactUsConfiguration < ::Spree::Preferences::Configuration
    preference :use_captcha, :boolean, default: false
    preference :use_honeypot, :boolean, default: false
    preference :recaptcha_public_key, :string
    preference :recaptcha_private_key, :string
    preference :recaptcha_theme, :string, default: 'red'
    preference :inquiry_types, :array, default: %i[site_support sales website_issue
                                                   suggestion other]
  end
end
