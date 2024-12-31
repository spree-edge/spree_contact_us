# frozen_string_literal: true

module Spree::InquiriesHelper
  def inquiry_types_translated
    types = Spree::ContactUsConfiguration[:inquiry_types].dup

    types = YAML.safe_load Spree::ContactUsConfiguration[:inquiry_types] unless types.respond_to? :collect

    # Translate types, use string for missing translations
    types.collect { |i| Spree.t(i, default: i.to_s) }
  end
end
