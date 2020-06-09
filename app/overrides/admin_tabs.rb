# frozen_string_literal: true

Deface::Override.new(virtual_path: 'spree/admin/shared/_main_menu',
                     name: 'spree_contact_us_inquiries_tab',
                     insert_bottom: 'nav',
                     partial: 'spree/admin/shared/menu/inquiries'
                    )

Deface::Override.new(virtual_path: 'spree/admin/shared/sub_menu/_configuration',
                     name: 'inquiries_admin_configurations_menu',
                     original: '35aede11c44b8ceff0be2d90bafd334d9d9b2ae2',
                     insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
                     text: "<%= configurations_sidebar_menu_item Spree.t(:inquiries_settings, scope: :inquiries), admin_inquiry_settings_path %>"
                    )
