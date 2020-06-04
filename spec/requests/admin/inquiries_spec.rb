# frozen_string_literal: true

require 'spec_helper'

describe 'Inquiries Entry', type: :request do
  context 'as admin user', :js do
    let(:admin_user) { create(:admin_user) }

    before(:each) do
      sign_in_as!(admin_user)

      binding.pry
      visit spree.admin_path
    end

    context 'index page' do
      it 'should display blog titles' do
        expect(page).to have_content('First blog entry')
      end
      it 'should display blog published_at' do
        expect(page).to have_content('11 Mar 2010')
      end
      # it 'should display blog visible' do
      #   expect(page).to have_css('.icon.icon-edit')
      # end
    end
  end
end
