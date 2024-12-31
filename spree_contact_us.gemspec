# frozen_string_literal: true

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_contact_us'
  s.version     = '1.1.1'
  s.summary     = 'Contact Us'
  s.description = 'Contact form with captcha for Spree e-commerce'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Alexander Negoda'
  s.email             = 'alexander.negoda@gmail.com'

  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'recaptcha'
  s.add_dependency 'spree_core', '~> 4.0'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'pry-byebug'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'webdrivers'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'database_cleaner'
end
