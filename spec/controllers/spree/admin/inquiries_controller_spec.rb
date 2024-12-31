# frozen_string_literal: true

require 'spec_helper'

describe Spree::Admin::InquiriesController do
  it 'responds to #index' do
    stub_authorization!
    spree_get :index
    should respond_with(:success)
    assigns(:collection).should_not be_nil
  end
end
