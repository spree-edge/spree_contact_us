# frozen_string_literal: true

module SpreeContactUs
  class Engine < Rails::Engine
    engine_name 'spree_contact_us'

    config.autoload_paths += %W[#{config.root}/lib]

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_contact_us.environment', before: 'spree.environment' do |app|
      require File.join(File.dirname(__FILE__), '../../app/models/spree_contact_us/spree_contact_us_configuration.rb')
    end

    initializer 'spree_contact_us.environment', before: :load_config_initializers do |_app|
      ::Spree::ContactUsConfiguration = ::SpreeContactUs::SpreeContactUsConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')).sort.each do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end

      Spree::Ability.register_ability(::ContactUsAbility)
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
