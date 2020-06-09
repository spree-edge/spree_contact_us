# frozen_string_literal: true

require 'spec_helper'

describe 'Inquiries Entry', type: :request do
  context 'as admin user', :js do
    let(:admin_user) { create(:admin_user) }
    let(:inquiry_list) { create_list(:inquiry, 100) }
    let(:last_inquiry) { inquiry_list.last }

    before(:each) do
      sign_in_as!(admin_user)

      visit spree.admin_path
    end

    it 'link to inquiries in left menu' do
      expect(page).to have_content('Inquiries')
    end

    it 'navigate to inquiries' do
      click_link 'Inquiries'

      expect(page).to have_content('No Inquiry found')
    end

    it 'navigate to inquiry' do
      last_inquiry

      click_link 'Inquiries'
      click_link last_inquiry.name

      expect(page).to have_content(Spree.t(:inquiry, scope: :inquiries))
    end

    context 'property' do
      before do
        create(:inquiry_full)
        visit spree.admin_inquiry_path(last_inquiry)
      end

      it 'date' do
        expect(page).to have_content(I18n.l(last_inquiry.created_at))
      end

      it 'name' do
        expect(page).to have_content(last_inquiry.name)
      end

      it 'email' do
        expect(page).to have_content(last_inquiry.email)
      end

      it 'phone_number' do
        expect(page).to have_content(last_inquiry.phone_number)
      end

      it 'inquiry_type' do
        expect(page).to have_content(last_inquiry.inquiry_type)
      end

      it 'order_no' do
        expect(page).to have_content(last_inquiry.order_no)
      end

      it 'message' do
        expect(page).to have_content(last_inquiry.message)
      end

      it 'http_remote_addr' do
        expect(page).to have_content(last_inquiry.http_remote_addr)
      end

      it 'http_user_agent' do
        expect(page).to have_content(last_inquiry.http_user_agent)
      end

      it 'client_viewport_size' do
        expect(page).to have_content(last_inquiry.client_viewport_size)
      end
    end
  end
end
