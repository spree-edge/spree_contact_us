# frozen_string_literal: true

FactoryBot.define do
  factory :inquiry, class: Spree::Inquiry do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    message { FFaker::Lorem.sentence }
    phone_number { FFaker::PhoneNumber.phone_number }
  end

  factory :inquiry_full, class: Spree::Inquiry do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    message { FFaker::Lorem.sentence }
    phone_number { FFaker::PhoneNumber.phone_number }
    inquiry_type { Spree::Inquiry::INQUIRY_TYPES.sample }
    order_no { 'R0000000000' }
    http_user_agent { "User-Agent #{FFaker::Internet.user_name}" }
    http_remote_addr { FFaker::InternetSE.ip_v4_address }
    client_viewport_size { rand(800..1000) }
  end
end
