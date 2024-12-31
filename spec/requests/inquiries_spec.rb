# frozen_string_literal: true

require 'spec_helper'

describe 'Inquiries Entry', type: :request do
  context 'as admin user', :js do
    let(:last_inquiry) { Spree::Inquiry.last }

    before(:each) do
      visit spree.contact_path
    end

    it 'title for page' do
      expect(page).to have_content(Spree.t(:title, scope: :inquiries))
    end

    it 'send form' do
      fill_in Spree.t(:contact_name, scope: :inquiries), with: 'Joe Bloggs'
      fill_in Spree.t(:contact_email, scope: :inquiries), with: 'user@example.com'
      fill_in Spree.t(:contact_phone_number, scope: :inquiries), with: '+0000000000'
      fill_in Spree.t(:inquiry_order_no, scope: :inquiries), with: 'R0000000'
      fill_in Spree.t(:inquiry_message), with: 'Lorem ipsum dolor sit amet.'

      click_on Spree.t(:send_inquiry)

      expect(page).to have_content(Spree.t(:on_send_message))
      expect(last_inquiry.name).to eq('Joe Bloggs')
      expect(last_inquiry.client_viewport_size).to eq('')
    end
  end
end
