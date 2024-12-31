Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
    Rails.application.config.spree_backend.main_menu.add_to_section(
      'integrations',
      ::Spree::Admin::MainMenu::ItemBuilder.new(
      'inquiries.inquiry',
        ::Spree::Core::Engine.routes.url_helpers.admin_inquiries_path
      )
      .with_manage_ability_check(::Spree::Inquiry)
      .with_match_path('/inquiries')
      .build
    )

    Rails.application.config.spree_backend.main_menu.add_to_section(
      'integrations',
      ::Spree::Admin::MainMenu::ItemBuilder.new(
        'inquiries.inquiry_settings',
        ::Spree::Core::Engine.routes.url_helpers.admin_inquiry_settings_path
      )
      .with_manage_ability_check(::Spree::Inquiry)
      .with_match_path('/inquiries_settings')
      .build
    )
  end
end
